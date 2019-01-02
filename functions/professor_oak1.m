function [speech_end] = professor_oak1

% figure('WindowButtonDownFcn',@ScreenIsPressed)

background = imread('Speech_1.png');

hfg = figure;
image(background);
set(hfg, 'Position', [400 50 800 800])
axis off equal
[y,Fs] = audioread('FireRedLeafGreen.mp3');
sound(y,Fs)

set(hfg,'KeyPressFcn',@ScreenIsPressed);
speech_end = 0;


line{1} = 'Hello there!';
line{2} = 'Welcome to the world of MATLAB!';
line{3} = 'My name is Graham!';
line{4} = 'People call me the MATLAB Master.';
line{5} = 'This world is inhabited by a coding system called MATLAB.';

line{6} = 'For some people, MATLAB is for leisure coding.';
line{7} = 'Others use it for work or school.';
line{8} = 'Myself?';
line{9} = 'I teach MATLAB as a profession.';
line{10} = 'Your very own MATLAB legend is about to unfold!';

line{11} = 'A world of dreams and adventures with MALTAB awaits!';
line{12} = 'Your first lesson begins now.';
line{13} = 'Use the ''a'' and ''d'' keys to move left and right across the screen.';


long = length(line);
count = 1;

size = [.175 0.15 .69 .2];
a = annotation('textbox',size,'String',line{1},'LineStyle','none','FontSize',13);
while speech_end == 0
    drawnow
end

    function ScreenIsPressed(~,eventdata)
        switch eventdata.Character
            case 13
                count = count+1;
                speech = line{1};
                speech1 = line{6};
                speech2 = line{11};
                if count <= long
                    for j = 2:count
                        if j < 6
                            speech = [speech,' ',line{j}];
                            set(a,'String',speech);
                        elseif j == 6
                            set(a,'String',speech1);
                        elseif (j < 11) && (j > 6);
                            speech1 = [speech1,' ',line{j}];
                            set(a,'String',speech1);
                        elseif j == 11
                            set(a,'String',speech2);
                        elseif (j <= 13) && (j > 11)
                            speech2 = [speech2,' ',line{j}];
                            set(a,'String',speech2);
                        end
                    end
                else
                    close all
                    clear all
                    speech_end = 1;
                    
                end
        end
    end
end
