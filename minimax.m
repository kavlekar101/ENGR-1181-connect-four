function [value] = minimax(isMaximizing,depth,board,places)
%This is where the computer will use the minimax algorithm to determine the
%best possbile move for it at a given position.
%Inputs: whether or not the current player is the ai
%        depth of the tree
%        the board that keeps track of the moves played
%        the places the computer has gone to in the tree not necessarily
%        the total moves the computer has done
%Outputs: value of the played move.

    %check if there is a winner so the loop can be broken out of
    [winner,combinations] = checkIfWinner(board);
    value = 0;
    if (winner ~= 1)
        %fprintf("winner\n")
        %value = round(rand()*100)+1;
        %if the winner is the ai, then return a high positive value
        if(winner == 3)
            value = 1000;
            return
        %if the winner is the human, then return a low negative value
        else
            value = -100;
            return
        end
    %if the max depth is reached (only 5 here because of no optimizations)
    %return the static evaluation of the board.
    elseif(depth == 5)
        center = 0;
        %fprintf("evaluating\n")
        %checks the places the computer has gone within the minimax
        %algorithm and if they are in column 4, the center, then the center
        %value gets increased
        for i = 1:2:size(places,1)
            if(places(i,2) == 4)
                center = center + 1;
            end
        end
        %obtains the amount of three and two in a row for both players
        threeMax = combinations(1,2);
        threeMin = combinations(1,1);
        twoMax = combinations(2,2);
        twoMin = combinations(2,1);
        %weighting of the combinations and produceds a value for the
        %current board state.
        value = value + threeMax*4+twoMax*2-threeMin*4-twoMin*2+center;
    elseif(isMaximizing)
        %fprintf("maximizing\n")
        %try to find the best move for the maximizing player (ai)
        highestValue = -10000;
        for i = 1:7
            row = findLowestOpenRow(board,i);
            %first check if that row is open. if it is not open, move on to
            %the next row.
            if(row)
                %go in the current row
                board(row,i) = 3;
                %update the places vector to include this new move
                places(end+1,:) = [row,i];
                %call minimax on this particular node.
                value = minimax(~isMaximizing,depth+1,board,places);
                %erase the move
                board(row,i) = 1;
                %if a higher value is found, update highestValue
                if(value>highestValue)
                    highestValue = value;
                end
            else
                continue
            end
        end
        %return the highestValue
        value = highestValue;
    else
        %fprintf("minimizing\n")
        %try to find the best move for the minimizing player (human)
        lowestValue = 10000;
        for i = 1:7
            row = findLowestOpenRow(board,i);
            %if the row is not open, move on to the next open row.
            if(row)
                %play a move in the certain row.
                board(row,i) = 2;
                %call minimax on this particular node
                value = minimax(~isMaximizing,depth+1,board,places);
                %erase the move
                board(row,i) = 1;
                %update the lowestValue found
                if(value<lowestValue)
                    lowestValue = value;
                end
            else
                continue
            end
        end
        %return the lowestValue for this node.
        value = lowestValue;
    end
end

