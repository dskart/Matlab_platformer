%--------------------RUN THIS SCRIPT TO PLAY THE GAME ---------------------

%loads all the files necessary for the menu screen
[Y,Fs] = audioread('loading_song.mp3');
player = audioplayer(Y,Fs);
[A,map, alpha] = imread('ENG-105.png');
[C,map2, D] = imread('PRESS-ENTER.png');
[B ] = imread('loading background.jpg');

%plays the menu song and images of the menu screen
play(player);
F = figure;
image(B)
box off
axis off
truesize
hold on
A = image(A,'AlphaData',alpha);
set(A,'XData',[100 400],'YData',[50 150])
C =image(C,'AlphaData',D);
set(C,'XData',[100 400],'YData',[350 400])

%waits for a button press to start the game ( ENTER )
k=0;
while ~k
k = waitforbuttonpress;
end

%clears everything for the game to start
clear all
close all

%loads the first intro professor
professor_oak1();
%loads the first level in Mygame function
WIN = MyGame('1 level map.png','collision map level 1.png','victory map level 1.png',...
    'death map level 1.png','level 1 song.mp3');
%if the output of the game is WIN =0 then you lost the game and the if loop
%breaks the script (does not paly the rest of the game)
if WIN == 0
    return;
end
clear all


%does the same for the rest of the levels and prof_oak introductions
professor_oak_2()
WIN = MyGame('2 level map.png','collision map level 2.png','victory map level 2.png',...
    'death map level 2.png','level 2 song.mp3');
if WIN == 0
    return;
end
clear all

professor_oak_3()
WIN = MyGame('3 level map.png','collision map level 3.png','victory map level 3.png',...
    'death map level 3.png','level 3 song.mp3');
if WIN == 0
    return;
end
clear all

professor_oak_4()
WIN = MyGame('4 level map.png','collision map level 4.png','victory map level 4.png',...
    'death map level 4.png','level 4 song.mp3');
if WIN == 0
    return;
end
clear all

professor_oak_5()
WIN = MyGame('5 level map.png','collision map level 5.png','victory map level 5.png',...
    'death map level 5.png','level 5 song.mp3');
if WIN == 0
    return;
end
clear all

WIN = MyGame('6 level map.png','collision map level 6.png','victory map level 6.png',...
    'no death.png','level 6 song.mp3');
if WIN == 0
    return;
end
clear all
professor_oak_7()


