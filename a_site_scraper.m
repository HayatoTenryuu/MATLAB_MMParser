%% This file pulls the data from the web.

function a_site_scraper()

    % Setup:
    clear
    clc
    
    try

        % Pull data from Mega Million Texas website
        site = "https://www.texaslottery.com/export/sites/lottery/Games/Mega_Millions/Winning_Numbers/index.html_2013354932.html";   % All years of powerball was 1992 
        stroo = webread(site);

        % Fix things that could kill fprintf prematurely
        stroo = regexprep(stroo, "\n{3,}", "\n");
        stroo = regexprep(stroo, "%", "percent");                           % This was the problem
        
        % Save that year's data as an HTML file.
        locale = dir;
        last = length(locale);
        aru = false;
    
        for q = 1:last
            finder = locale(q).name;
            if finder == "data"
                aru = true;
            end
        end

        if aru == false
            mkdir data;         
        end

        nama = "Mega Millions data.html";
        fid = fopen("data\" + nama, "w+");
        nbytes = fprintf(fid, stroo);
        fclose(fid);

    catch exception
        
        % If this throws an error, check your internet connection, as all data comes from a single site.
        fprintf("Cannot access website!" + newline);

    end
    
    return;
end