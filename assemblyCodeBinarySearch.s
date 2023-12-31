.data 
size: .word 12 
target: .word 71 
result: .word 0 
array: .word 1, 3, 14, 69, 71, 125, 255, 400, 1024, 1025, 1920, 9000 

.text
# Tristan Flores

main: 
# Initialize lower and upper bounds as well as target
lw $t0, target 
lw $t1, result # initial lower bound 
lw $t2, size # initial upper bound 

binary_search_loop: 
# Calculate middle index
add $t3, $t1, $t2 
srl $t3, $t3, 1 # $t3 = (lower + upper) / 2 
sll $t5, $t3, 2
lw $t4, array($t5) 

# Compare middle index value with target value
beq $t4, $t0, target_found 
blt $t4, $t0, target_higher 
bgt $t4, $t0, target_lower 

target_higher: 
# New lower bound = old mid + 1
addi $t1, $t3, 1 
j binary_search_loop 

target_lower: 
# New upper bound = old mid - 1
addi $t2, $t3, -1 
j binary_search_loop 

target_found: 
# Stores answer to 0x10010008 and exits
sw $t3, 0x10010008 
ori $2, $0, 10 
syscall
