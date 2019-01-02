function [speech_end] = professor_oak_5

background = imread('Speech_1.png');
hfg = figure;
image(background);
set(hfg, 'Position', [400 50 800 800])
axis off equal
[y,Fs] = audioread('FireRedLeafGreen.mp3');
sound(y,Fs)
set(hfg,'KeyPressFcn',@ScreenIsPressed);

speech_end = 0;

line{1} = 'I''m proud of you for making it this far - you''re only one lesson away from finishing the course!';
line{2} = 'Don''t worry about the next one though.';
line{3} = 'As your professor, I want you guys to succeed.';
line{4} = 'So I would never do something like...';
line{5} = ' make the final level IMPOSSIBLE to complete...';
line{6} = 'Never.';
line{7} = 'Nope.';
line{8} = 'Not me.';

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
                speech2 = line{8};
                if count <= long
                    for j = 2:count
                        if j < 3
                            speech = [speech,' ',line{j}];
                            set(a,'String',speech);
                        elseif j == 3
                            set(a,'String',speech1);
                        elseif (j <= 8) && (j > 3);
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
