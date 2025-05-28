# Function to check if a queen can be placed on board[row][col] 
def is_safe(board, row, col, N): 
    # Check this column on upper side 
    for i in range(row): 
        if board[i][col] == 1: 
            return False 
     
    # Check upper diagonal on left side 
    for i, j in zip(range(row - 1, -1, -1), range(col - 1, -1, -1)): 
        if board[i][j] == 1: 
            return False 
     
    # Check upper diagonal on right side 
    for i, j in zip(range(row - 1, -1, -1), range(col + 1, N)): 
        if board[i][j] == 1: 
            return False 
     
    return True 
 
# Function to solve the N Queens problem using backtracking 
def solve_n_queens(board, row, N): 
    # If all queens are placed, return True 
    if row >= N: 
        return True 
     
    # Try placing the queen in all columns for the current row 
    for col in range(N): 
        if is_safe(board, row, col, N): 
            # Place the queen 
            board[row][col] = 1 
 
            # Recur to place the next queen 
            if solve_n_queens(board, row + 1, N): 
                return True 
 
            # Backtrack if placing queen in current position does not work 
            board[row][col] = 0 
 
    return False 
 
# Function to print the board 
def print_board(board, N): 
    for i in range(N): 
        for j in range(N): 
            if board[i][j] == 1: 
                print("Q", end=" ") 
            else: 
                print(".", end=" ") 
        print() 
 
# Main function to solve the N Queens problem 
def n_queens(N): 
    board = [[0 for _ in range(N)] for _ in range(N)] 
 
    if not solve_n_queens(board, 0, N): 
        print("Solution does not exist") 
        return False 
 
    print_board(board, N) 
    return True 
 
# Example usage for N=4 
N = 4 
n_queens(N) 
