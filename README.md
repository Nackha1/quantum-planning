# quantum-planning
Automated Reasoning project by Nazareno Piccin

## Problem description
The input data is $n$ and a Boolean Matrix $n \times n$. The goal is reaching the unitary $n \times n$ Matrix. There is an unique schema of "evolution" rule: Choose two (different) rows $i$ and $j$ ($i < j$ or $j < i$ are both ok) and replace row $i$ with their XOR (bit-to-bit). Find the minimum path leading to the unitary Matrix (btw, if the determinant of the starting matrix is not 0, the path exists always, consider that when you prepare tests).
