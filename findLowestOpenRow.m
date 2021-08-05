function [row] = findLowestOpenRow(board,col)
%Finds the lowest open row of the selected column

    %initializes row variable
    row = 0;
    %loops through the rows from bottom to top
    for i = 6:-1:1
        if(board(i,col) == 1)
            %stops looping if the current row is open
            row = i;
            break
        end
    end
    %this function returns 0 if the column is full
end

