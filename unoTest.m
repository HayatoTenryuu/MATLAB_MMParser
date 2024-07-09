%% This file performs the first test.

function [bestw, bestr, fig] = firstTest(contents) 

    %-----------------------------------------------------------------
    % First test - find the count and odds of each number, then plot:
    %-----------------------------------------------------------------
    x = [1:70];
    x2 = [1:25];
    y = [];
    y2 = [];
    z = [];
    z2 = [];
    
    goodlen = 0;
    
    % Get rid of empty cells:
    for a = 1:length(table2array(contents(:, "Date:")))
        if cell2mat(table2array(contents(a, "Date:"))) == ""
            goodlen = a-1;
            break;
        end
    end
    
    data1 = string(table2array(contents(1:goodlen, "First ball:")));
    data2 = string(table2array(contents(1:goodlen, "Second ball:")));
    data3 = string(table2array(contents(1:goodlen, "Third ball:")));
    data4 = string(table2array(contents(1:goodlen, "Fourth ball:")));
    data5 = string(table2array(contents(1:goodlen, "Fifth ball:")));
    data6 = string(table2array(contents(1:goodlen, "Gold Ball:")));
    
    % White balls:
    for b = 1:70
    
        count = 0;

        % Give people something to look at while analysis occurs:
        fprintf("The time remaining on white is: " + (70-b) + newline);
        
        for c = 1:goodlen
            if str2double(data1(c)) == b
                count = count + 1;
            end
            if str2double(data2(c)) == b
                count = count + 1;
            end
            if str2double(data3(c)) == b
                count = count + 1;
            end
            if str2double(data4(c)) == b
                count = count + 1;
            end
            if str2double(data5(c)) == b
                count = count + 1;
            end
        end
    
        y(b) = count;
        z(b) = y(b) / length(data1);        % The denominator is how many drawings there have been
    
    end
    
    % Red balls:
    for b = 1:25
    
        count = 0;
        
        fprintf("The time remaining on gold is: " + (25-b) + newline);
        
        for c = 1:goodlen
            if str2double(data6(c)) == b
                count = count + 1;
            end
        end
    
        y2(b) = count;
        z2(b) = y2(b) / length(data6);        % The denominator is how many gold balls have been pulled.
    end
    
    % Frequency plot as a show of how many times each WHITE number has been pulled:
    set(0,'DefaultFigureVisible','off');
    set(0,'defaultAxesToolbarVisible','off');
    fig = figure("Visible","off");
    
    subplot(2, 2, 1);
    bar(x, y, FaceColor="blue", EdgeColor="black");
    disableDefaultInteractivity(gca);
    title("Frequency of each white number");
    xlabel("Ball Numbers");
    ylabel("Count");
    ylim([min(y)/4, max(y)*1.25]);
    
    % Odds plot as a show of how many times each WHITE number has been pulled,
    % relative to the number of WHITE balls that have been pulled.
    subplot(2, 2, 2);
    bar(x, 100.*z, FaceColor="blue", EdgeColor="black");
    disableDefaultInteractivity(gca);
    title("Odds of each white number being drawn");
    xlabel("Numbers");
    ylabel("Percentage of times pulled");
    ylim([4 12]);

    % Frequency plot as a show of how many times each GOLD number has been pulled
    subplot(2, 2, 3);
    bar(x2, y2, FaceColor="#FFBE00", EdgeColor="black");
    disableDefaultInteractivity(gca);
    title("Frequency of each gold number");
    xlabel("Ball Numbers");
    ylabel("Count");
    ylim([min(y2)/4, max(y2)*1.25]);
    
    % Odds plot as a show of how many times each GOLD number has been pulled, 
    % relative to the number of RED balls that have been pulled.
    subplot(2, 2, 4);
    bar(x2, 100.*z2, FaceColor="#FFBE00", EdgeColor="black");
    disableDefaultInteractivity(gca);
    title("Odds of each gold number being drawn");
    xlabel("Numbers");
    ylabel("Percentage of times pulled");
    ylim([0 7]);
        
    % Return the ordered white group and ordered red group:
    bestw = [x; y];
    bestw = sortrows(bestw', 2, "descend")';
    bestw = bestw(1, :);

    bestr = [x2; y2];
    bestr = sortrows(bestr', 2, "descend")';
    bestr = bestr(1, :);

end