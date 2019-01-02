function [speech_end] = professor_oak_2

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

line{1} = 'Congrats on completing your first lesson!';
line{2} = 'I know that it probably a lot of work, but the class instructions don''t get much harder than this.';
line{3} = 'For this next level, let''s try jumping.';

line{4} = 'Use the ''w'' key to jump up onto platforms that appear on the screen.';
line{5} = 'Good luck!';

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
                speech1 = line{4};
                if count <= long
                    for j = 2:count
                        if j < 4
                            speech = [speech,' ',line{j}];
                            set(a,'String',speech);
                        elseif j == 4
                            set(a,'String',speech1);
                        elseif (j <= 5) && (j > 4);
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
