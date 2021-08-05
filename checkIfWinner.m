function [winner,combinations] = checkIfWinner(board)
%Checks if there is a winner in the board configuartion and also returns
%the number of three and two in a row for each player
%   Detailed explanation goes here
%sets the winner variable to 0(false/empty)


    winner = 1;
    player = 1;
    combinations = zeros(2,2);
    %loops through the rows from 6 to 1 going from the bottom row to the
    %topmost row.
    connectFour = zeros(4,2);
    for row = 6:-1:1
        %loops the columns from left to right.
        for col = 1:7
            %doesn't need to check the empty spaces and the spaces that are
            %occupied by the opponent.
            if(board(row,col)==1)
                continue
            end
            player = board(row,col);
            for i = 0:3
                %This if statement prevents the checker from going to
                %column 0 and 8.
                if((col == 7 && (i == 0 || i == 1))||(col == 1 && i == 3))
                    continue
                end
                %this code increases the change in row and column needed to
                %check the neighbors.
                theta = pi*i/4;
                changeC = cos(theta);
                changeR = -sin(theta);
                if(mod(i,2)~=0)
                    changeC = changeC*sqrt(2);
                    changeR = changeR*sqrt(2);
                end
                changeC = round(changeC);
                changeR = round(changeR);
                %prevents the checker for checking a connect four that
                %would go off of the board
                if((row <= 3 && changeR == -1) || (col >= 5 && changeC == 1)...
                        || (col <= 3 && changeC == -1))
                    continue
                end
                %creates the path of the potential connect four.
                path = [board(row,col),board(row+changeR,col+changeC),...
                    board(row+2*changeR,col+2*changeC)...
                    ,board(row+3*changeR,col+3*changeC)];
                connectFour = path == player;
                %checks if the player determined earlier in the loop has a
                %connect four in the certain direction.
                if(sum(connectFour) == 4)
                    connectFour = [[row,col];[row+changeR,col+changeC];...
                        [row+2*changeR,col+2*changeC];...
                        [row+3*changeR,col+3*changeC]];
                    winner = player;
                    break
                end
                pieces = (path == player | path == 1);
                %logic for keeping track of the threes and twos in a row
                %for each player.
                if(sum(pieces) == 4)
                    if(sum(connectFour) == 3)
                        if(player == 2)
                            combinations(1,1) = combinations(1,1) + 1;
                        else
                            combinations(1,2) = combinations(1,2) + 1;
                        end
                    elseif(sum(connectFour) == 2)
                        if(player == 2)
                            combinations(2,1) = combinations(1,1) + 1;
                        else
                            combinations(2,2) = combinations(1,2) + 1;
                        end
                    end
                end
            end
            %break out of the loop if a connect four is found because check
            %winner is checked everytime a piece is played.
            if(sum(connectFour == 4))
                break
            end
        end
        %break out of the loop if a connect four is found because check
        %winner is checked everytime a piece is played.
        if(sum(connectFour == 4))
                break
        end
    end
end

