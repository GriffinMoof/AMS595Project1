%Task 1
function answer = monteCarloFor(n)
    % Initialize variables for the Monte Carlo simulation
    insideCircle = 0;
    totalPoints = n;

    %Declare the current point we are on
    currentPoint = 0;

    %Declare arrays we we put out data into
    estimate = zeros(1, totalPoints);
    deviation = zeros(1, totalPoints);

    %For each interation we want to create a random point, figure out if 
    % its in the circle,and calculate the current estimation for the number
    %of points we have and its deviation from the actual value

    for i = 1:totalPoints
        currentPoint = currentPoint + 1;

        %Create a random coordinate (x,y)
        x = rand;
        y = rand;

        %If the point lies within the circle, insideCircle+=1
        if x^2 + y^2 <= 1
            insideCircle = insideCircle + 1;
        end

        %Calculate what current estimation is and insert it in estimate[]
        currentEstimation = (insideCircle/currentPoint) * 4;
        estimate(currentPoint) = currentEstimation;

        %Insert Deviation into deviation[], deviation = currentEstimation - pi
        deviation(currentPoint) = currentEstimation - pi;
    end

    % Number of points in circle divided by 
    % the total number of points is pi/4
    answer = (insideCircle/totalPoints) * 4;

    %Create Plot and plot points in estimate[] and deviation[]
    plot(estimate,".",LineStyle="none");
    hold on;
    plot(deviation,".",LineStyle="none");
    title("Computed Value of Pi and its Deviation for " + n + " Points");
    xlabel(("Number of Points"));
    ylabel("Value");
    legend("Estimate of Pi","Deviation from Pi")
    hold off;
end

function runtime(n, pointCountDifference)
    %n will be the number of MonteCarlo simulation we want to run
    %pointCountDifference will be the number of points we increase
    %each Monte Carlo Simulation by.

    %So if n = 5 and pointCountDifference = 50, we will track the runtime
    %for Monte Carlo simulations of size 50, 100, 150, 200, 250

    %Create a array of size n for elapsed time and precision
    elapsedTime =1:n;
    precision = 1:n;

    %Create tiled layout to display all plots
    figure("Name","Plotted Estimates and Deviation");
    tiledlayout;
    
    
    for i = 1:n
        %Go to next tile in layout and start timer.
        nexttile;
        tic;
        estimate = monteCarloFor(i * pointCountDifference);
        %If precision = 0, our simulation is perfectly precise.
        
        %Stop timer
        elapsedTime(i) = toc;

        %Precision = estimate/pi
        precision(i) =  estimate - pi;
    end

    %Plot elapsed time vs how precise our simulation was.
    figure(Name="Precision vs Elapsed Time");
    plot(elapsedTime,precision,'.');
    title("Measure of Precision by Elapsed Time");
    xlabel("Elapsed Time");
    ylabel("Precision: Estimate / Pi")
    

    %Label each point with the corresponding number of points
    %it took to get the estimation.
    a = [pointCountDifference:pointCountDifference:n*pointCountDifference]';
    pointLabel = cellstr(num2str(a));
    text(elapsedTime, precision,pointLabel);
end

%Task 2
function answer = monteCarloWhile(n)
    % Initialize variables for the Monte Carlo simulation
    insideCircle = 0;
    numIterations = 0;

    %Declare the current point and previous point to calculate
    %the tolerance

    currentEstimation = 0;
    previousEstimation = 0;

    %Set tolerance = 1 so that while loop can proceed

    tolerance = 1;

    %We want to accomplish a similar task as before, track point in the
    %circle and the total number of points (numIterations)

    %This time we must use a while loop with a specific level of precision.
    %To summerize, if the tolerance is between -(0.1)^levelOfPrecision and
    %(0.1)^levelOfPrecision, then we want the while loop to stop.

    %So if levelOfPrecision = 2, the while loop will stop when 
    % -0.01 <= currentEstimation - previousEstimation <= 0.01

    %Additionally I added currentEstimation == 0 | currenEstimation == 4
    %to prevent the while loop from stopping on the first few iterations
    
    while (currentEstimation == 0 |currentEstimation == 4 | ...
            tolerance > (0.1^(n)) | ...
            tolerance < -(0.1^(n)))
        numIterations = numIterations + 1;

        %Create a random coordinate (x,y)
        x = rand;
        y = rand;

        %If the point lies within the circle, insideCircle+=1
        if x^2 + y^2 <= 1
            insideCircle = insideCircle + 1;
        end

        %Calculate what current estimation is and insert it in estimate[]
        currentEstimation = (insideCircle/numIterations) * 4;
        
        %calculate deviation of previous estimation from current estimation
        tolerance = currentEstimation - previousEstimation;
        previousEstimation = currentEstimation;
        
    end

    % Number of points in circle divided by 
    % the total number of points is pi/4
    answer = round(currentEstimation,n, 'significant');
    fprintf("Total Iterations: %i Estimated Value: %f",numIterations,answer);
    
end

%Task 3
function answer = monteCarloUser()
    %Take user input.
    precisionLevel = input("Please enter desired level of precision: ");

    %Plot the quarter circle.
    theta = linspace(0, pi/2, 100); 
    x = cos(theta);
    y = sin(theta);
    plot(x, y);
    axis equal;
    hold on;
    xlabel("X");
    ylabel("Y");
    title("Monte Carlo Method in Quadrant I");

    %Plot line x = 1 and y = 1 and x = 0 and y = 0.
    xline(1);
    yline(1);
    xline(0);
    yline(0);

    %Initialize variables for the Monte Carlo simulation.
    insideCircle = 0;
    numPoints = 0;

    %Declare the current point and previous point to calculate
    %the tolerance.
    currentEstimation = 0;
    previousEstimation = 0;

    %Set tolerance = 1 so that while loop can proceed.
    tolerance = 1;

    %While Loop behaves same as monteCarloWhile.
    while (currentEstimation == 0 |currentEstimation == 4 | ...
            tolerance > (0.1^(precisionLevel)) | ...
            tolerance < -(0.1^(precisionLevel)))
        numPoints = numPoints + 1;

        %Create a random coordinate (x,y).
        x = rand;
        y = rand;

        %If the point lies within the circle, insideCircle+=1.
        %Additionally plot the point.
        if x^2 + y^2 <= 1
            insideCircle = insideCircle + 1;
            plot(x,y,'o','color','r');
        else
            plot(x,y,'o','color','b');
        end
        drawnow; %Updates plot in real time.
        
        %Calculate what current estimation is.
        currentEstimation = (insideCircle/numPoints) * 4;
        
        %Calculate tolerance.
        tolerance = currentEstimation - previousEstimation;
        previousEstimation = currentEstimation;
        
    end

    % Number of points in circle divided by 
    % the total number of points is pi/4.
    answer = round(currentEstimation,precisionLevel, 'significant');

    %Plot the final estimate.
    plot(answer,0,"hexagram",'Color','y',MarkerFaceColor= ' y');
    text(answer,0,"The Estimate is " + answer);
    %Print the estimate and number of iterations.
    fprintf("Total Iterations: %i\nEstimated Value: %f\n",numPoints,answer);
    hold off;
end


monteCarloUser();