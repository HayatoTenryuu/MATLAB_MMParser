%% Application entry point if using code.

classdef main < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                    matlab.ui.Figure
        Image_4                     matlab.ui.control.Image
        Image_3                     matlab.ui.control.Image
        Image_2                     matlab.ui.control.Image
        Image                       matlab.ui.control.Image
        Label                       matlab.ui.control.Label
        Label_5                     matlab.ui.control.Label
        Label_4                     matlab.ui.control.Label
        Label_3                     matlab.ui.control.Label
        Label_6                     matlab.ui.control.Label
        GiveMeSuggestionsButton     matlab.ui.control.Button
        AnalyzeDataButton           matlab.ui.control.Button
        OrganizeDataButton          matlab.ui.control.Button
        ImportHistoricalDataButton  matlab.ui.control.Button
        uBestEverPowerballNumberGeneratoruLabel  matlab.ui.control.Label
    end

    properties (Access = public)
        a = [];
        b = [];
        c = figure;
    end
    
    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app)
            app.Image.Visible = "off";
            app.Image_2.Visible = "off";
            app.Image_3.Visible = "off";
            app.Image_4.Visible = "off";
        end

        % Button pushed function: ImportHistoricalDataButton
        function ImportHistoricalDataButtonPushed(app, event)

            % Loading image on:
            app.Image.Visible = "on";
            drawnow;

            % Download powerball data:
            a_site_scraper;

            % Done label on:
            app.Image.Visible = "off";
            app.Label_6.Text = "Done!";
            drawnow;
        end

        % Button pushed function: OrganizeDataButton
        function OrganizeDataButtonPushed(app, event)

            % Loading image on:
            app.Image_2.Visible = "on";
            drawnow;

            % Organize data:
            b_data_organizer;

            % Done label on:
            app.Image_2.Visible = "off";
            app.Label_3.Text = "Done!";
            drawnow;
        end

        % Button pushed function: AnalyzeDataButton
        function AnalyzeDataButtonPushed(app, event)

            % Loading image on:
            app.Image_3.Visible = "on";
            drawnow;

            % Analyze data:
            [app.a, app.b, app.c] = c_data_analyzer();

            % Done label on:
            app.Image_3.Visible = "off";
            app.Label_4.Text = "Done!";
            drawnow;
        end

        % Button pushed function: GiveMeSuggestionsButton
        function GiveMeSuggestionsButtonPushed(app, event)

            % Get number of recommendations from user:
            prompt = {"I have two methods of picking lottery numbers, " + ...
                "and I will do each for you. How many sets of lottery " + ...
                "picks do you want?"};
            dlgtitle = "How many suggestions should I generate?";
            fieldsize = [1 65];
            answer = inputdlg(prompt,dlgtitle,fieldsize);
            
            % Create recommendations:
            if length(answer) > 0 && str2double(cell2mat(answer(1))) >= 1
                
                % Loading image on:
                app.Image_4.Visible = "on";
                drawnow;

                % Clear previous recommendations:
                locale = dir;
                last = length(locale);
                
                for q = 1:last
                    finder = locale(q).name;
                    if finder == "Your Recommendations"
                        rmdir("Your Recommendations\", "s");
                    end
                end
                

                % Run recommendations script as often as requested:
                for q = 1:str2double(cell2mat(answer(1)))
                    d_make_recommendation(app.a, app.b, app.c, q);
                end

                % Done label on:
                app.Image_4.Visible = "off";
                app.Label_5.Text = "Done!";
                drawnow;
    
                % Open output:
                winopen(".\Your Recommendations\");
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 760 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create uBestEverPowerballNumberGeneratoruLabel
            app.uBestEverPowerballNumberGeneratoruLabel = uilabel(app.UIFigure);
            app.uBestEverPowerballNumberGeneratoruLabel.HorizontalAlignment = 'center';
            app.uBestEverPowerballNumberGeneratoruLabel.FontSize = 28;
            app.uBestEverPowerballNumberGeneratoruLabel.Interpreter = 'html';
            app.uBestEverPowerballNumberGeneratoruLabel.Position = [36 397 690 69];
            app.uBestEverPowerballNumberGeneratoruLabel.Text = '<u> Best Ever Mega Millions Number Generator* </u>';

            % Create ImportHistoricalDataButton
            app.ImportHistoricalDataButton = uibutton(app.UIFigure, 'push');
            app.ImportHistoricalDataButton.ButtonPushedFcn = createCallbackFcn(app, @ImportHistoricalDataButtonPushed, true);
            app.ImportHistoricalDataButton.FontSize = 16;
            app.ImportHistoricalDataButton.Position = [200 320 188 47];
            app.ImportHistoricalDataButton.Text = 'Import Historical Data';

            % Create OrganizeDataButton
            app.OrganizeDataButton = uibutton(app.UIFigure, 'push');
            app.OrganizeDataButton.ButtonPushedFcn = createCallbackFcn(app, @OrganizeDataButtonPushed, true);
            app.OrganizeDataButton.FontSize = 16;
            app.OrganizeDataButton.Position = [200 240 188 47];
            app.OrganizeDataButton.Text = 'Organize Data';

            % Create AnalyzeDataButton
            app.AnalyzeDataButton = uibutton(app.UIFigure, 'push');
            app.AnalyzeDataButton.ButtonPushedFcn = createCallbackFcn(app, @AnalyzeDataButtonPushed, true);
            app.AnalyzeDataButton.FontSize = 16;
            app.AnalyzeDataButton.Position = [200 160 188 47];
            app.AnalyzeDataButton.Text = 'Analyze Data';

            % Create GiveMeSuggestionsButton
            app.GiveMeSuggestionsButton = uibutton(app.UIFigure, 'push');
            app.GiveMeSuggestionsButton.ButtonPushedFcn = createCallbackFcn(app, @GiveMeSuggestionsButtonPushed, true);
            app.GiveMeSuggestionsButton.FontSize = 16;
            app.GiveMeSuggestionsButton.Position = [200 80 188 47];
            app.GiveMeSuggestionsButton.Text = 'Give Me Suggestions';

            % Create Label_6
            app.Label_6 = uilabel(app.UIFigure);
            app.Label_6.Tag = 'Label_6';
            app.Label_6.HorizontalAlignment = 'center';
            app.Label_6.FontSize = 16;
            app.Label_6.Position = [475 326 67 34];
            app.Label_6.Text = ' ';

            % Create Label_3
            app.Label_3 = uilabel(app.UIFigure);
            app.Label_3.HorizontalAlignment = 'center';
            app.Label_3.FontSize = 16;
            app.Label_3.Position = [475 246 67 34];
            app.Label_3.Text = ' ';

            % Create Label_4
            app.Label_4 = uilabel(app.UIFigure);
            app.Label_4.HorizontalAlignment = 'center';
            app.Label_4.FontSize = 16;
            app.Label_4.Position = [475 166 67 34];
            app.Label_4.Text = ' ';

            % Create Label_5
            app.Label_5 = uilabel(app.UIFigure);
            app.Label_5.HorizontalAlignment = 'center';
            app.Label_5.FontSize = 16;
            app.Label_5.Position = [475 86 67 34];
            app.Label_5.Text = ' ';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.HorizontalAlignment = 'center';
            app.Label.Position = [147 17 467 22];
            app.Label.Text = '* = odds are better than going to the cashier and asking for a random set of numbers.';

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [460 325 100 40];
            app.Image.ImageSource = fullfile(pathToMLAPP, 'resources', 'hzk6C.gif');

            % Create Image_2
            app.Image_2 = uiimage(app.UIFigure);
            app.Image_2.Position = [460 245 100 40];
            app.Image_2.ImageSource = fullfile(pathToMLAPP, 'resources', 'hzk6C.gif');

            % Create Image_3
            app.Image_3 = uiimage(app.UIFigure);
            app.Image_3.Position = [460 165 100 40];
            app.Image_3.ImageSource = fullfile(pathToMLAPP, 'resources', 'hzk6C.gif');

            % Create Image_4
            app.Image_4 = uiimage(app.UIFigure);
            app.Image_4.Position = [460 85 100 40];
            app.Image_4.ImageSource = fullfile(pathToMLAPP, 'resources', 'hzk6C.gif');

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @startupFcn)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end