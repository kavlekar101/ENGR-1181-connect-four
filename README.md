# ENGR-1181-connect-four

This is a connect four game that was coded in MATLAB. It uses the minimax algorithm to calculate moves for the ai.
This program also uses part of the flooding algorithm that was developed in the minimax algorithm by me, in the checkwinner file.
Even though there was an easier way to see if there was a winner in connect four (just by checking if the last piece completes a four in a row),
the flooding algorithm was used to check for a winner because it simultaneous checked how many three in a row and two in a rows there were when it was used inside
the minimax function.
