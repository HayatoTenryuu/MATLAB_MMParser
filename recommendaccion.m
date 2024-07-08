%% This script is used to give the user recommendations based on the tests done.

function [b1, b2, b3, b4, b5, bg, b21, b22, b23, b24, b25, bg2, ...
    fig1, fig2] = recommendaccion(bestw, bestr, fig)

    %-----------------
    % Recommendations:
    %-----------------

    % Create cetegories for white ball selection based on likelihood:
    likelyw = bestw(1:(floor(end/3)));
    middlew = bestw((floor(end/3) + 1): (floor(2*end/3)));
    unlikelyw = bestw((floor(2*end/3) + 1):end);

        % 1, 2, 2 Schema
    r1 = floor((length(likelyw)) * rand(1));
    r2 = floor((length(middlew)) * rand(1));
    r3 = floor((length(middlew)) * rand(1));
    r4 = floor((length(unlikelyw)) * rand(1));
    r5 = floor((length(unlikelyw)) * rand(1));

    % Sufficiently small rands end up as index 0:
    if r1 == 0
        r1 = 1;
    end
    if r2 == 0
        r2 = 1;
    end
    if r3 == 0
        r3 = 1;
    end
    if r4 == 0
        r4 = 1;
    end
    if r5 == 0
        r5 = 1;
    end

    b1 = likelyw(r1);
    b2 = middlew(r2);
    b3 = middlew(r3);
    b4 = unlikelyw(r4);
    b5 = unlikelyw(r5);

        % 1, 1, 3 Schema
    r21 = floor((length(likelyw)) * rand(1));
    r22 = floor((length(middlew)) * rand(1));
    r23 = floor((length(unlikelyw)) * rand(1));
    r24 = floor((length(unlikelyw)) * rand(1));
    r25 = floor((length(unlikelyw)) * rand(1));

    % Sufficiently small rands end up as index 0:
    if r21 == 0
        r21 = 1;
    end
    if r22 == 0
        r22 = 1;
    end
    if r23 == 0
        r23 = 1;
    end
    if r24 == 0
        r24 = 1;
    end
    if r25 == 0
        r25 = 1;
    end

    b21 = likelyw(r21);
    b22 = middlew(r22);
    b23 = unlikelyw(r23);
    b24 = unlikelyw(r24);
    b25 = unlikelyw(r25);

        % Do the same for gold balls:
    likelyg = bestr(1:floor(end/3));
    middleg = bestr((floor(end/3) + 1): floor(2*end/3));
    unlikelyg = bestr((floor(2*end/3) + 1):end);

    rr1 = floor((length(unlikelyg)) * rand(1));
    rr2 = floor((length(likelyg)) * rand(1));
    rr3 = floor((length(middleg)) * rand(1));
    rrdecider = (2) * rand(1);

    % Protect against zeros
    if rr1 == 0
        rr1 = 1;
    end
    if rr2 == 0
        rr2 = 1;
    end
    if rr3 == 0
        rr3 = 1;
    end
    
    rr21 = floor((length(unlikelyg)) * rand(1));
    rr22 = floor((length(likelyg)) * rand(1));
    rr23 = floor((length(middleg)) * rand(1));
    rrdecider2 = (2) * rand(1);

    % Protect against zeros
    if rr21 == 0
        rr21 = 1;
    end
    if rr22 == 0
        rr22 = 1;
    end
    if rr23 == 0
        rr23 = 1;
    end

    if rrdecider < 0.7
        bg = unlikelyg(rr1);
    elseif (rrdecider >= 0.7) && (rrdecider <= 1.3)
        bg = middleg(rr2);
    else
        bg = likelyg(rr3);
    end

    if rrdecider2 < 0.7
        bg2 = unlikelyg(rr21);
    elseif (rrdecider2 >= 0.7) && (rrdecider2 <= 1.3)
        bg2 = middleg(rr22);
    else
        bg2 = likelyg(rr23);
    end

    % Stopgap for equivalence of two white balls if that issue arises:
        % 1, 2, 2
    equal = false;
    if (r1 == r2) || (r1 == r3) || (r1 == r4) || (r1 == r5) || (r2 == r3) || (r2 == r4) || (r2 == r5) || (r3 == r4) || (r3 == r5) || (r4 == r5)
        equal = true;
    end

    while equal
        r1 = floor((length(likelyw)) * rand(1));
        r2 = floor((length(middlew)) * rand(1));
        r3 = floor((length(middlew)) * rand(1));
        r4 = floor((length(unlikelyw)) * rand(1));
        r5 = floor((length(unlikelyw)) * rand(1));

        % Sufficiently small rands end up as index 0:
        if r1 == 0
            r1 = 1;
        end
        if r2 == 0
            r2 = 1;
        end
        if r3 == 0
            r3 = 1;
        end
        if r4 == 0
            r4 = 1;
        end
        if r5 == 0
            r5 = 1;
        end

        b1 = likelyw(r1);
        b2 = middlew(r2);
        b3 = middlew(r3);
        b4 = unlikelyw(r4);
        b5 = unlikelyw(r5);
        
        if (r1 == r2) || (r1 == r3) || (r1 == r4) || (r1 == r5) || (r2 == r3) || (r2 == r4) || (r2 == r5) || (r3 == r4) || (r3 == r5) || (r4 == r5)
            equal = true;
        else
            equal = false;
        end
    end

        % 1, 1, 3
    equal = false;
    if (r21 == r22) || (r21 == r23) || (r21 == r24) || (r21 == r25) || (r22 == r23) || (r22 == r24) || (r22 == r25) || (r23 == r24) || (r23 == r25) || (r24 == r25)
        equal = true;
    end

    while equal==true
        r21 = floor((length(likelyw)) * rand(1));
        r22 = floor((length(middlew)) * rand(1));
        r23 = floor((length(unlikelyw)) * rand(1));
        r24 = floor((length(unlikelyw)) * rand(1));
        r25 = floor((length(unlikelyw)) * rand(1));
    
        % Sufficiently small rands end up as index 0:
        if r21 == 0
            r21 = 1;
        end
        if r22 == 0
            r22 = 1;
        end
        if r23 == 0
            r23 = 1;
        end
        if r24 == 0
            r24 = 1;
        end
        if r25 == 0
            r25 = 1;
        end

        b21 = likelyw(r21);
        b22 = middlew(r22);
        b23 = unlikelyw(r23);
        b24 = unlikelyw(r24);
        b25 = unlikelyw(r25);

        if (r21 == r22) || (r21 == r23) || (r21 == r24) || (r21 == r25) || (r22 == r23) || (r22 == r24) || (r22 == r25) || (r23 == r24) || (r23 == r25) || (r24 == r25)
            equal = true;
        else
            equal = false;
        end
    end

    % Display the likely numbers
    % msgbox("The top 10 most likely white numbers are: " +  newline + ...
    %     bestw(1, 1) + ", " + bestw(1, 2) + ", " + bestw(1, 3) + ", " + bestw(1, 4) + ", " + ...
    %     bestw(1, 5) + ", " + bestw(1, 6) + ", " + bestw(1, 7) + ", " + bestw(1, 8) + ", " + ...
    %     bestw(1, 9) + ", and " + bestw(1, 10), "Best white numbers");
    % 
    % msgbox("The top 5 most likely red numbers are: " + newline + ...
    %     bestr(1, 1) + ", " + bestr(1, 2) + ", " + bestr(1, 3) + ", " + bestr(1, 4) + ", and " + ...
    %     bestr(1, 5), "Best red numbers");

    % Display recommendations
    % msgbox("Your personal recommendation based on a 1, 2, 2 schema is:" + newline + ...
    %     b1 + ", " + b2 + ", " + b3 + ", " + b4 + ", " + b5 + ", with powerball " + bg, "Recommended numbers");
    % 
    % msgbox("Your personal recommendation based on a 1, 1, 3 schema is:" + newline + ...
    %     b21 + ", " + b22 + ", " + b23 + ", " + b24 + ", " + b25 + ", with powerball " + bg2, "Recommended numbers");

    % Customize figure:
    set(0,'DefaultFigureVisible','off');

    fig1 = figure;
    copyobj(get(fig,'Children'), fig1);
    fig.Visible = "off";
    fig1.Visible = "off";
    
    fig2 = figure;
    copyobj(get(fig,'Children'), fig2);
    fig.Visible = "off";
    fig2.Visible = "off";

        % 1, 2, 2 
    fig1.Name = "Data based on 1, 2, 2 Schema";
    fig1.NumberTitle = "off";
    fig1.Position = [fig1.Position(1)-50, fig1.Position(2)- 80, 700, 600];
    fig1.Children(4, 1).Children.FaceColor = "flat";
    fig1.Children(3, 1).Children.FaceColor = "flat";
    fig1.Children(2, 1).Children.FaceColor = "flat";
    fig1.Children(1, 1).Children.FaceColor = "flat";

        % Color the recommended numbers differently:
    for col = 1:70
        if fig1.Children(4, 1).Children.XData(col) == b1
            fig1.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig1.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        elseif fig1.Children(4, 1).Children.XData(col) == b2
            fig1.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig1.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        elseif fig1.Children(4, 1).Children.XData(col) == b3
            fig1.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig1.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        elseif fig1.Children(4, 1).Children.XData(col) == b4
            fig1.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig1.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        elseif fig1.Children(4, 1).Children.XData(col) == b5
            fig1.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig1.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        else
            fig1.Children(4, 1).Children.CData(col, :) = [0, 0, 1];
            fig1.Children(3, 1).Children.CData(col, :) = [0, 0, 1];
        end
    end
    for col = 1:25
        if fig1.Children(2, 1).Children.XData(col) == bg
            fig1.Children(2, 1).Children.CData(col, :) = [0.75, 0, 1];
            fig1.Children(1, 1).Children.CData(col, :) = [0.75, 0, 1];
        else
            fig1.Children(2, 1).Children.CData(col, :) = [1, 0.7451, 0];
            fig1.Children(1, 1).Children.CData(col, :) = [1, 0.7451, 0];
        end
    end

        % 1, 1, 3
    fig2.Name = "Data based on 1, 1, 3 Schema";
    fig2.NumberTitle = "off";
    fig2.Position = [fig2.Position(1)-50, fig2.Position(2)- 80, 700, 600];
    fig2.Children(4, 1).Children.FaceColor = "flat";
    fig2.Children(3, 1).Children.FaceColor = "flat";
    fig2.Children(2, 1).Children.FaceColor = "flat";
    fig2.Children(1, 1).Children.FaceColor = "flat";

        % Color the recommended numbers differently:
    for col = 1:70
        if fig2.Children(4, 1).Children.XData(col) == b21
            fig2.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig2.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        elseif fig2.Children(4, 1).Children.XData(col) == b22
            fig2.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig2.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        elseif fig2.Children(4, 1).Children.XData(col) == b23
            fig2.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig2.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        elseif fig2.Children(4, 1).Children.XData(col) == b24
            fig2.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig2.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        elseif fig2.Children(4, 1).Children.XData(col) == b25
            fig2.Children(4, 1).Children.CData(col, :) = [1, 0, 0.75];
            fig2.Children(3, 1).Children.CData(col, :) = [1, 0, 0.75];
        else
            fig2.Children(4, 1).Children.CData(col, :) = [0, 0, 1];
            fig2.Children(3, 1).Children.CData(col, :) = [0, 0, 1];
        end
    end
    for col = 1:25
        if fig2.Children(2, 1).Children.XData(col) == bg2
            fig2.Children(2, 1).Children.CData(col, :) = [0.75, 0, 1];
            fig2.Children(1, 1).Children.CData(col, :) = [0.75, 0, 1];
        else
            fig2.Children(2, 1).Children.CData(col, :) = [1, 0.7451, 0];
            fig2.Children(1, 1).Children.CData(col, :) = [1, 0.7451, 0];
        end
    end

    % Show figure:
    % fig1.Visible = "on";
    % fig2.Visible = "on";

    return;

end