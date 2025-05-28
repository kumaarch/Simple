from pgmpy.models import BayesianNetwork
from pgmpy.factors.discrete import TabularCPD
from pgmpy.inference import VariableElimination

model = BayesianNetwork([
    ('Rain', 'Traffic'),
    ('Rain', 'Umbrella'),
    ('Traffic', 'Late')
])

cpd_rain = TabularCPD(variable='Rain', variable_card=2, values=[[0.7], [0.3]])
cpd_traffic = TabularCPD(
    variable='Traffic', variable_card=2,
    values=[[0.8, 0.2], [0.2, 0.8]],
    evidence=['Rain'], evidence_card=[2]
)
cpd_umbrella = TabularCPD(
    variable='Umbrella', variable_card=2,
    values=[[0.9, 0.2], [0.1, 0.8]],
    evidence=['Rain'], evidence_card=[2]
)
cpd_late = TabularCPD(
    variable='Late', variable_card=2,
    values=[[0.6, 0.1], [0.4, 0.9]],
    evidence=['Traffic'], evidence_card=[2]
)

model.add_cpds(cpd_rain, cpd_traffic, cpd_umbrella, cpd_late)
print("Model is valid:", model.check_model())

inference = VariableElimination(model)

query_result = inference.query(variables=['Late'], evidence={'Rain': 1})
print("\nProbability of being late given it is raining:")
print(query_result)

query_result_traffic = inference.query(variables=['Traffic'], evidence={'Rain': 0})
print("\nProbability of traffic given it is not raining:")
print(query_result_traffic)

query_result_umbrella = inference.query(variables=['Umbrella'])
print("\nProbability of using an umbrella:")
print(query_result_umbrella)