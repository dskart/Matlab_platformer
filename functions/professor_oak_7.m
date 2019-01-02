function [speech_end] = professor_oak_7
figure('KeyPressFcn',@ScreenIsPressed)

background = imread('Speech_1.png');

image(background);
axis off equal
[y,Fs] = audioread('FireRedLeafGreen.mp3');
sound(y,Fs)
fig = gcf;
set(gcf,'Position',[400 50 800 800],'KeyPressFcn',@ScreenIsPressed);
speech_end = 0;

line{1} = 'Huh.';
line{2} = 'You beat that one.';
line{3} = 'Well this is awkward.';
line{4} = 'I mean,';
line{5} = 'I guess you pass.';
line{6} = 'Congratulations.';
line{7} = 'You must have put a lot of time and effort into this course.';

line{8} = '- you even made that last level look like a walk in the park.';
line{9} = 'I''m in awe of your phenomenal MATLAB skills.';
line{10} = 'I must''ve really done my job well!';
line{11} = 'Go me!';

long = length(line);
count = 1;

size = [.175 0.15 .69 .2];
a = annotation('textbox',size,'String',line{1},'LineStyle','none','FontSize',13,'units','pixels');
while speech_end == 0
    drawnow
end

    function ScreenIsPressed(~,eventdata)
        switch eventdata.Character
            case 13
                count = count+1;
                speech = line{1};
                speech1 = line{5};
                speech2 = line{8};
                if count <= long
                    for j = 2:count
                        if j < 5
                            speech = [speech,' ',line{j}];
                            set(a,'String',speech);
                        elseif j == 5
                            set(a,'String',speech1);
                        elseif (j <= 15) && (j > 5);
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
