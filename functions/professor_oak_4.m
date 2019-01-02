function [speech_end] = professor_oak_4

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

line{1} = 'Nice job on finishing that third lesson.';
line{2} = 'I wish I could say the material is going to ease up, but the next few levels are really going to test your skills.';

line{3} = 'I''ll let you in on a trick though -';
line{4} = ' if you ever find yourself getting overwhelmed or exhausted,';
line{5} = ' my trick is to pop open a Mountain Dew,';
line{6} = ' and just take everything one step at a time.';

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
