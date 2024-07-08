%% This file organizes the data and exports excel files.

function b_data_organizer()

    % Setup:
    clear
    clc
    
    % Initialize arrays:
    dateArray = {};
    b1Array = {};
    b2Array = {};
    b3Array = {};
    b4Array = {};
    b5Array = {};
    gbArray = {};

    data2 = [];

    try 

        fid = fopen("data\Mega Millions data.html", "r");                       % Open as read-only so you don't make the data files empty
        contents = fileread("data\Mega Millions data.html");                    % Import the file's text
        
        % Date keyword search:
        search_line_a = '<td><a class="detailsLink" href="/export/sites/lottery/Games/Mega_Millions/Winning_Numbers/details.html_';
        search_line_a_tail = '.html">';

        % Ball keyword search:
        search_line_b = '<td>';    
        search_line_b_tail = '</td>';      

        % Grab all data:
        date_points = regexp(contents, search_line_a + "\d{10}" + search_line_a_tail);                      % Find the location/index of each date
        wb_points = regexp(contents, search_line_b + "[0123456789\s-]{16,23}" + search_line_b_tail);        % Find the location/index of each white ball number
        unclean_g = regexp(contents, search_line_b + "[0123456789]{0,3}" + search_line_b_tail);             % Find the location/index of each gold ball number
        
        % Filter the multiplier data out of the gold ball data:
        for u = 1:length(wb_points)

            if (unclean_g(u) - wb_points(u) > 35) || (wb_points(u) - unclean_g(u) > 35)
               unclean_g = [unclean_g(1:u-1), unclean_g(u+1:end)];

               if (unclean_g(u) - wb_points(u) > 35) || (wb_points(u) - unclean_g(u) > 35)
                   unclean_g = [unclean_g(1:u-1), unclean_g(u+1:end)];
               else
                   continue;
               end

            else
               continue;
            end
        end

        if length(unclean_g) > length(wb_points)
            unclean_g = [unclean_g(1:length(wb_points))];
        end

        gb_points = unclean_g;
    
        % Find values of each variable and assign it to arrays:
        for v = 1:length(date_points)
       
            % Capture the 10-digit date (YYYY-MM-DD format):
            dateArray = [dateArray, contents((date_points(v) + length(search_line_a) + 10 + length(search_line_a_tail)):(date_points(v) + length(search_line_a) + 10 + length(search_line_a_tail) + 9))];
            
            % Capture the white ball numbers (assume 2 digits long):
            whiteset = contents((wb_points(v) + length(search_line_b)):(wb_points(v) + length(search_line_b) + 23));
            noomloc = regexp(whiteset, '\d+');

            b1Array = [b1Array, whiteset(noomloc(1):noomloc(1) + 1)];
            b2Array = [b2Array, whiteset(noomloc(2):noomloc(2) + 1)];
            b3Array = [b3Array, whiteset(noomloc(3):noomloc(3) + 1)];
            b4Array = [b4Array, whiteset(noomloc(4):noomloc(4) + 1)];
            b5Array = [b5Array, whiteset(noomloc(5):noomloc(5) + 1)];
            
            % Capture the gold ball numbers (assume 2 digits long):
            gbArray = [gbArray, contents((gb_points(v) + length(search_line_b)):(gb_points(v) + length(search_line_b) + 1))];

            % Test if the ball numbers are one or two digits long. If only one digit, kill the second character in the array:
            B1 = char(b1Array(v));                                              % convert the cell to a char array
            if (double(B1(2)) == 60) || (double(B1(2)) == 32)                   % double('<') returns 60, double(' ') returns 32
                b1Array(v) = cellstr(B1(1));                                    % convert back to a cell and reassign
            end

            B2 = char(b2Array(v));
            if (double(B2(2)) == 60) || (double(B2(2)) == 32)
                b2Array(v) = cellstr(B2(1));
            end

            B3 = char(b3Array(v));
            if (double(B3(2)) == 60) || (double(B3(2)) == 32)
                b3Array(v) = cellstr(B3(1));
            end

            B4 = char(b4Array(v));
            if (double(B4(2)) == 60) || (double(B4(2)) == 32)
                b4Array(v) = cellstr(B4(1));
            end

            B5 = char(b5Array(v));
            if (double(B5(2)) == 60) || (double(B5(2)) == 32)
                b5Array(v) = cellstr(B5(1));
            end

            GB = char(gbArray(v));
            if (double(GB(2)) == 60) || (double(GB(2)) == 32)
                gbArray(v) = cellstr(GB(1));
            end

        end
        
        fclose(fid);
        v = 0;
        
    catch err

        fprintf("We have an error..." + newline);

    end

    % Make table for each file's data (yearly):
    dateTable = string(dateArray);
    b1Table = string(b1Array);
    b2Table = string(b2Array);
    b3Table = string(b3Array);
    b4Table = string(b4Array);
    b5Table = string(b5Array);
    gbTable = string(gbArray);

    % Make table with rows for each value type:
    data = table(flip(dateTable'), flip(b1Table'), flip(b2Table'), flip(b3Table'), flip(b4Table'), flip(b5Table'), flip(gbTable'), ...
        'VariableNames', ["Date:", "First ball:", "Second ball:", "Third ball:", "Fourth ball:", "Fifth ball:", "Gold Ball:"]);


    % Table for all files (overall)
    newrow = [flip(dateTable'), flip(b1Table'), flip(b2Table'), flip(b3Table'), flip(b4Table'), flip(b5Table'), flip(gbTable')];
    block = extractBetween(newrow(1, 1), 1, 4);
    if str2num(block) > 2017
        data2 = [data2; newrow];
    end

    % Output yearly data table to Excel File:
    locale = dir;
    last = length(locale);
    aru = false;

    for q = 1:last
        finder = locale(q).name;
        if finder == "excel"
            aru = true;
        end
    end

    if aru == false
        mkdir excel;   
    elseif (aru == true) && (u == 0)
        rmdir("excel\", "s");
        mkdir excel;
    end


    % Output total data to Excel File
    headers = ["Date:", "First ball:", "Second ball:", "Third ball:", "Fourth ball:", "Fifth ball:", "Gold Ball:"];
    data2 = [headers; data2];
    data2 = table(data2, 'VariableNames', " ");

    filename = "excel\Mega Millions total data.xlsx";
    if isfile(filename)
        delete(filename);
    end
    writetable(data2, filename,'Sheet',1,'Range','D4');

    return;
end