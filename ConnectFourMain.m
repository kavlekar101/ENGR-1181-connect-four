rematch = true;
while(rematch)
    clc
    clear
    % Initialize scene
    my_scene = simpleGameEngine('ConnectFour.png',86,101);
    % Set up variables to name the various sprites
    empty_sprite = 1;
    red_sprite = 2;
    black_sprite = 3;
    % Display empty board
    board = empty_sprite * ones(6,7);
    drawScene(my_scene,board)
    
    gameType = input("Enter 1 for a one player game and enter 2 for a 2 player game!\n");

    %initialize the loop variables
    pieces = 0;
    winner = 1;

    while(winner == 1 && pieces ~= 42)
        %checks whose turn it is. If the number of pieces are even,
        %then it is red/player 1 turn. If the number of pieces are odd,
        %it is black/player 2 turn.
        if(mod(pieces,2) == 0)
            [row,col] = getMouseInput(my_scene);
            %checks if the move played was an available move and keeps "asking
            %for one" if a playable move is not played.
            while(findLowestOpenRow(board,col) == 0)
                [row,col] = getMouseInput(my_scene);
            end
            row = findLowestOpenRow(board,col);
            %puts the red piece and logs the player move in the
            %board matrix
            board(row,col) = red_sprite;
            finalRow = row;
            finalCol = col;
        else
            %if a two player game is chosen, the this part checks for the
            %mouseclick and puts a chip in the correct location.
            if(gameType == 2)
                [row,col] = getMouseInput(my_scene);
                %checks if the move played was an available move and keeps "asking
                %for one" if a playable move is not played.
                while(findLowestOpenRow(board,col) == 0)
                    [row,col] = getMouseInput(my_scene);
                end
                row = findLowestOpenRow(board,col);
                %puts the black piece and logs the move in the board matrix
                board(row,col) = black_sprite;
                finalRow = row;
                finalCol = col;
            %if the one player option is chosen then this executes the
            %minimax algorithm to chose the best spot for the computer to
            %go in and puts the piece in that spot.
            else
                tic
                %keeps track of the values associated with each column
                possibilities = ones(1,7)*-100000;
                %loops through all of the columns and calls minimax on each
                %lowest position if the column is open
                for i = 1:7
                    row2 = findLowestOpenRow(board,i);
                    if(row2 == 0)
                        continue
                    end
                    %computer goes in this spot
                    board(row2,i) = 3;
                    places = [row2,i];
                    possibilities(i) = minimax(false,0,board,places);
                    %computer removes the move
                    board(row2,i) = 1;
                end
                %finds the column number that has the highest value
                %associated with it.
                [placeHolder,col2] = max(possibilities);
                row2 = findLowestOpenRow(board,col2);
                board(row2,col2) = 3;
                toc
                finalRow = row2;
                finalCol = col2;
            end
        end
        %updates the amount of pieces on the board.
        pieces = pieces + 1;
        %checks if there is a winner only after 7 pieces
        if(pieces >= 7)
            [winner] = checkIfWinner(board);
        end
        %updates the visual board.
        drawScene(my_scene,board)
    end
    %displays which player won
    str = "Player";
    if(winner~=1)
        str = join([str,winner-1,"won!"]);
        if(gameType == 1)
            if(winner == 2)
                str = "User beat the computer!";
            else
                str = "Computer beat the user!";
            end
        end
    else
        str = "It was a tie!";
    end
    title(str)
    figure(my_scene.my_figure);
    %logic for if the user wants to play again
    answer = input("Would you like to play again? ('y'/'n')",'s');
    if(answer == 'n')
        rematch = false;
    else
        rematch = true;
    end
end