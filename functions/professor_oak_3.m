function [speech_end] = professor_oak_3

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

line{1} = 'Oh, I forgot to tell you.';
line{2} = 'That ''Grade'' bar in the top right-hand corner of your screen tells you how well you''re doing in the course so far.';

line{3} = 'When you fall off a platform into water or onto spikes, your grade will decrease by a letter.';
line{4} = 'But, since I know you guys have put A LOT OF EFFORT in this project...';
line{5} = '*cough*';
line{6} = 'I mean...';

line{7} = 'in your homeworks...';
line{8} = 'Your grade gets reset whenever you hit another level.';

line{9} = 'Now let''s kick it up a notch.';
line{10} = 'Good luck!';

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
                speech1 = line{3};
                speech2 = line{7};
                if count <= long
                    for j = 2:count
                        if j < 3
                            speech = [speech,' ',line{j}];
                            set(a,'String',speech);
                        elseif j == 3
                            set(a,'String',speech1);
                        elseif (j <= 6) && (j > 3);
                            speech1 = [speech1,' ',line{j}];
                            set(a,'String',speech1);
                        elseif j == 7
                            set(a,'String',speech2);
                        elseif (j <= 10) && (j > 7);
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
