%This function creates the whole gameplay, you just need to input some
%files for the map and an audio file for the music, It can work for any map
%you create made of 16x16 pixel blocks and 29x16 rectangles made of those blocks
%
%-maplevel is the RGB value of the map you owant to display
%-collisionmap is a n*m matrix the size of the maplevel where collision =
%255 and empty  = 0
%-DeathMap is the same as collisionmap but it is 255 where the character
%dies
%-victoryMap is again the same, but for the are where the victory of the
%level is
%-levelSong is the song you want your level to play
%
% The output is used to determined if you are game over or not 
function WIN = MyGame(maplevel,collisionmap,victoryMap,DeathMap,levelSong)
clc
clf
close all
WIN = 1; % you are not game over yet

%load songs and plays it
[LevelSong,Song2] = audioread(levelSong);
player = audioplayer(LevelSong,Song2);
play(player)

%loads the game over song and image 
[GameOverSong,Song1] = audioread('game over song.mp3');
[GameOver,~, AGameOver] = imread('Game Over.png');

%loads the images for your life/Grade
[Grade,~, AGrade] = imread('Grade--.png');
[Aletter,~, AA] = imread('A.png');
[Bletter,~, AB] = imread('B.png');
[Cletter,~, AC] = imread('C.png');
[Dletter,~, AD] = imread('D.png');

%loads the animation frames to make your character run
[run2,~, Arun2] = imread('run 2.png');
run2 = flip(run2,1); %flips it around because it is upside down
Arun2 = flip(Arun2,1);
[run3,~, Arun3] = imread('run 3.png');
run3 = flip(run3,1);
Arun3 = flip(Arun3,1);
[run4,~, Arun4] = imread('run 4.png');
run4 = flip(run4,1);
Arun4 = flip(Arun4,1);

%loads the animation frames to make your character jump
[jumpUP,~, AjumpU] = imread('jump up.png');
jumpUP = flip(jumpUP,1); %flips it around because it is upside down
AjumpU = flip(AjumpU,1);
[jumpDOWN,~, AjumpD] = imread('jump down.png');
jumpDOWN = flip(jumpDOWN,1);
AjumpD = flip(AjumpD,1);


%loads the static image of the character and flips it around (upsidedown)
[Player,~, alpha] = imread('Player.png');
Player = flip(Player,1);
alpha = flip(alpha,1);

%creates the collision matrix of the character which will follow him
CollisionC =ones(21,16);

%reads the maplevel and assign it a Handle
B = imread(maplevel);

%gets the alpha data of the collisionmap (so that empty = 0 and 
%collision = 255
[~,~, Beta] = imread(collisionmap);
Beta = Beta./255;%makes the collision pixels = 1
Beta = uint16(Beta);%makes the matrix a unit16

%same thing for the victorymap and the death map
[~,~, Vmap] = imread(victoryMap);
Vmap = uint16(Vmap);
[~,~, Dmap] = imread(DeathMap);
Dmap = uint16(Dmap);

%makes every pixel in death = 375 and victory = 113233
Vmap =  (Vmap ./225).* 113233;
Dmap = (Dmap ./225).*375;
%adds all these matrix together in a a single matrix
% now collision = 1, death = 375, victory = 113233 and nothing = 0 in a
% single matix
Beta = Beta + Vmap;
Beta = Beta + Dmap;

%gets the size of the player
[Ya, Xa, ~] = size(Player);

%gets the size of the map
[Yb, Xb, ~]= size(B);

%sets the intial condition/position of the character and what we see of the
%map ( the camera)
y = 100;% location of the bottom of the character
x = 232;%the center of the camera ( 29*16 blocks)
x1 = x - (232-1);%the left limit of the camera
x2 = x+232;%the right limit of the camera

%now we are going to plot everything together
hfg = figure;%creates a figure 

image(B);%plots the RGB value of the map
hold on

%plots the character and sets its position in the camera
C = image(Player,'AlphaData',alpha);
set(C, 'XData', [ x1+100 x1+100+Xa],'YData', [y y-Ya])

%plots the collison of the character and position it at the same place
ColC = image(CollisionC);
set(ColC, 'XData', [ x1+108 x1+108+16],'YData', [y y-21],'Visible', 'off')

%plots the grade and first letter "A" and set their position 
Grade = image(Grade, 'AlphaData', AGrade);
set(Grade, 'XData', [ x1+300 x1+300+100],'YData', [10 33])
Letter = image(Aletter, 'AlphaData', AA);
set(Letter, 'XData', [ x1+400 x1+400+19],'YData', [10 33])

%creates the limits of the camera
ax.XLim = [ x1 x2 ];
ax.YLim = [ 0 Yb];
%positions the figure on the screen
set(hfg, 'Position', [400 50 800 800])
axis off equal

%creates the key handles for the 
set(hfg,'KeyPressFcn', @keyPress)
set(hfg, 'KeyReleaseFcn', @keyRelease)

%sets the variable for  the while loop/game
victory = 0; %variable for the while loop
cstate = 1; %if the character is alive or dead
vx = 0; %intial velocity in the x direction
vy = 50; %initial velocity in the y direction
g= 0; %initial gravity
InAir = 0; % checks if the character is in the Air or not
wWidth = 232; %aritary variable for the camera/equations
dt = 0.5; %time step
CollisionState =1; %if he is in collision (touching the ground or not)
ii = 0; %variable fo rthe amount of iteration in the while lop (for frames)
run =0; % check if the character is moving or not
jump = 0; % check if the character is jumping or not
life = 4; %sets the amount of lifes


%this while loop is what makes the game run, it only stops if you win the
%level or loose all your lifes
while ~victory
    if cstate == 1 %if the character is alive 
        %updates the appropriate grade depending on how many lifes you have
        %left
        if life == 3
            set(Letter,'Cdata',Bletter,'AlphaData',AB);
        elseif life == 2
            set(Letter,'Cdata',Cletter,'AlphaData',AC);
        elseif life ==1 
            set(Letter,'Cdata',Dletter,'AlphaData',AD);
        elseif life == 0
            cstate = 0;% if you have no more life, the character is dead
        end
        
        %creates teh frames for the character while he jumps
        if jump == 1
            if vy < 0 %while he is going up
                set(C,'Cdata',jumpUP,'AlphaData',AjumpU);
            elseif vy > 0 %while he is going down
                set(C,'Cdata',jumpDOWN,'AlphaData',AjumpD);
            else %sets ack the character to its original position
                set(C,'Cdata',Player,'AlphaData',alpha);
            end
        %creates the frames for the character while he runs/moves    
        elseif run == 1
            ii = ii +1; %counts the number of while loop iteration
            %every 10 loops updates the frames if he is still moving
            if ii == 1
                set(C,'Cdata',run2,'AlphaData',Arun2);
            elseif ii == 10
                set(C,'Cdata',run3,'AlphaData',Arun3);
            elseif ii == 20
                set(C,'Cdata',run4,'AlphaData',Arun4);
            elseif ii == 30
                set(C,'Cdata',Player,'AlphaData',alpha);
                ii = 0;  
            end
        %if he is not moving, sets him to his original state    
        else
            set(C,'Cdata',Player,'AlphaData',alpha);
            ii = 0; %starts the loop counter again
        end

        %calculates the upcoming y position of the character for a given Vy
        vy  = vy +g*0.1;
        y = y + vy*0.1;
        %find the Y border of the collisionMap of the character
        Yd = [round(y) round(y-21)];
        
        %rescales the borders of the Y if it ends up out of the map
        if 1>Yd(2) 
            y = 22;
            Yd(2) =1;
            Yd(1) = 22;
        elseif  303<Yd(1)
            Yd(2) = 303-21;
            Yd(1) = 303;
            y = 303; 
        end
        
        % checks if the character is in collision range or not, if he is
        % not then sets him as 'in the air'
        if CollisionState == 0
           InAir = 1; %is in the air so gravity is acting
           g = 10;
        else 
           InAir = 0;
           vy=0; %is not in the air so no y velocity or gravity
           jump = 0;
           g=0;
        end
      
        %calculates the upcoming x position (middle of the camera
        x = x + vx * dt;
        
        %if x is out of borders, rescale it
        if x+wWidth > Xb
            x = Xb-wWidth-eps;
        elseif x-wWidth < 1
            x = wWidth+eps;
        end
        %sets the border of the camera depending on x
        x1 = x-wWidth;
        x2 = x+wWidth;
        %finds the x border of the collision of the character
        Xd  = [round(x1+108) round(x1+108+16)];
        
        %checks under the natrix under the character to see if he is on a
        %platform by summing the Betamatrix of the same location, if it is
        %0 then he is not on a floor and collision = 0
        GMatrix = sum(Beta(Yd(1)+1, Xd(1):Xd(2)));
        if GMatrix == 0  
            CollisionState = 0;
        else 
            g=0;
        end
        
        % sums ups twice the Beta matrix at the same location that the
        % character to find if he is in a wall , dead, or wont the game
        SmallCollision = Beta(Yd(2):Yd(1), Xd(1):Xd(2));
        Asum = sum(SmallCollision);
        DAsum = sum(Asum);
        
        %we first check vitory, then we check death, then we check
        %collision
        
        %if the sum is bigger than 65535-1, then he is in the victory area,
        %end of the loop, end of the level
        if DAsum > 65535-1
            victory = 1;
        %if the sum is now bigger than 375-1 then he hit a beath zone
        elseif DAsum >375-1
            % takes away a life, reset the character and camera at teh
            % beguinning of the level
            life = life -1;
            y = 100;
            x = 232;
            x1 = x - (232-1);
            x2 = x+232;
            set(ColC, 'XData', [ x1+108 x1+108+16],'YData', [y y-21],'Visible', 'off')
            set(C, 'XData', [ x1+100 x1+100+Xa],'YData', [y y-Ya])
            axis([x1 x2 0 Yb])

        %if the sum is bigger than 0 now, means he is in a wall    
        elseif DAsum >0
            %finds the Beta matrix at one pixel shifted in every direction
            BetaC_up = Beta(Yd(2)-1 :Yd(1)-1, Xd(1):Xd(2)); %shifted up
            BetaC_down = Beta(Yd(2)+1 :Yd(1)+1, Xd(1):Xd(2)); %shifted down
            BetaC_left = Beta(Yd(2) :Yd(1), Xd(1)-1:Xd(2)-1); %shifted left
            BetaC_right = Beta(Yd(2) :Yd(1), Xd(1)+1:Xd(2)+1); %shifted right

            Sum_up = sum(sum(BetaC_up)); %double sum the up shifted matrix
            Sum_down = sum(sum(BetaC_down)); %double sum the down shifted matrix
            Sum_left = sum(sum(BetaC_left)); %double sum the left shifted matrix
            Sum_right = sum(sum(BetaC_right)); %double sum the right shifted matrix
            
            %compares the up and down shifted matrix, then the left and
            %rigth shifted matrix, and from this we can tell which side and
            %how much pixel he is 'in' the wall and then pushes him back than
            %much in the opposite direction 
            
            %he is hitting the ground under him
            if Sum_up < DAsum && Sum_down > DAsum 
                CollisionState = 1;
                y = y - DAsum/16;
            
            %he is hitting a ceiling above him
            elseif Sum_up > DAsum && Sum_down < DAsum 
                CollisionState = 1;
                y = y + DAsum/16;
            
            %he is hitting a wall on the left side of him
            elseif  Sum_left > DAsum && Sum_right < DAsum
                CollisionState = 1;
                x = x + DAsum/21;
            
            %he is hitting a wall on the right side of him
            elseif  Sum_left < DAsum && Sum_right > DAsum
                CollisionState = 1;
                x = x - DAsum/21;
            end
            
        %plots the camera and character and everything on the right 
        %position if he is not hitting anything    
        else
            axis([x1 x2 0 Yb])
            set(C, 'XData', [ x1+100 x1+100+Xa],'YData', [y y-Ya])
            set(ColC, 'XData', [ x1+108 x1+108+16],'YData', [y y-21])
            set(Grade, 'XData', [ x1+300 x1+300+100],'YData', [10 30])
            set(Letter, 'XData', [ x1+400 x1+400+19],'YData', [10 33])
        end

    %this if statement is activated if the character died
    elseif cstate == 0
        close all %closes all windows
        %plays the gameover audio
        player = audioplayer(GameOverSong,Song1);
        play(player)
        %plots the game over screen
        hfg = figure;
        image(GameOver,'AlphaData',AGameOver);
        set(hfg, 'Position', [400 50 800 800]); 
        axis off
        %makes the WIN ouput = 0
        WIN = 0;
        %waits for a keyboard or mouse input, when it happens breaks out of
        %the while loop
        k = waitforbuttonpress;
        if k == 1 || k == 0
            break
        end
     
    end
    %keeps updating the images
    drawnow
    
end
close all

    %these are the handle functions of the keyboard inputs when pressed
    function keyPress(~, eventdata)
        switch eventdata.Character
            case 'd' % makes the character move to the right
                vx = 7;
                run = 1;
            
            case 'a' %makes the character move to the left
                vx = -7;
                run =1;
            
            case 'w' % makes the character jump
                %makes him be in the air with no collision
                CollisionState = 0;
                jump = 1;
                %only creates a jumping initial velocity if he is touching
                %the ground (so there are no double jumps)
                if InAir ==0
                    vy = -40;
                end
               
            case 'n' %makes you able to skip a level (for noobs)
                victory = true;
                close all
        end
    end

    %these are the handle functions of the keyboard inputs when released
    function keyRelease(~, eventdata)
        switch eventdata.Character
            case 'd'%stops the character from moving right
                run = 0;
                vx = 0;
            
            case 'a' %stops the character from moving left
                vx = 0;
                run = 0; 
        end
    end
 
end
                
        
        
        
  


    
