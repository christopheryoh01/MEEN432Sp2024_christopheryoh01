path.pure_pursuit_lookaheaddist = 5;

path.radius = 200;
path.l_st = 900;

path.width = 15;

radius = path.radius;

l_st = path.l_st;

l_curve = pi * radius;

path.total_length = 2 * l_st + 2 * l_curve;

delta_s = 10;
npts = round(path.total_length/delta_s);

delta_s = path.total_length/(npts-1);

delta_theta = delta_s / radius;

path.xpath = zeros(npts,1);
path.ypath = zeros(npts,1);
path.tpath = zeros(npts,1);
path.xinpath = zeros(npts,1);
path.yinpath = zeros(npts,1);
path.xoutpath = zeros(npts,1);
path.youtpath = zeros(npts,1);

% Plot the track
[x,y] = track(path.total_length,radius,delta_s,delta_theta);
figure;
plot(x, y, 'Color', 'k', 'LineWidth', 15) % Linewidth is equal to width of track
axis equal;
xlabel('X [m]');
ylabel('Y [m]');
title('Race Track');
grid on

% Create the patch
z = 20; % Can adjust to width of car
x_car = [-z, z, z, -z];
y_car = [-z/2, -z/2, z/2, z/2];

% Create animated line
h = animatedline('Color','r');
patch_handle = patch(x_car,y_car,'y');
axis equal;

% Animate the car in track
for i = 2:length(x)
    addpoints(h, x(i), y(i));
    rotated_car = rotate(i, x_car, y_car, x, y);
    x_cm = x(i) + rotated_car(1,:);
    y_cm = y(i) + rotated_car(2,:);
    set(patch_handle, 'XData', x_cm, 'YData', y_cm)
    drawnow;
end

%%Functions
% Building the Track Function
function [x, y] = track(t_length, radius, delta_s, delta_theta)
    bot_strt_x = linspace(0, t_length, t_length / delta_s + 1);
    bot_strt_y = linspace(0, 0, t_length / delta_s + 1);
    theta_r = linspace(-pi/2, pi/2, (pi / (delta_theta * pi/180)));
    top_str_x = linspace(t_length, 0, t_length / delta_s + 1);
    top_str_y = linspace(radius*2, radius*2, t_length / delta_s + 1);
    theta_l = linspace(pi/2, 3*pi/2, (pi / (delta_theta * pi/180)));
    x = [bot_strt_x + radius, radius*cos(theta_r) + t_length + radius, top_str_x + radius, radius*cos(theta_l) + radius];
    y = [bot_strt_y, radius*sin(theta_r) + radius, top_str_y, radius*sin(theta_l) + radius];
end

% Rotation Function
function rotated = rotate(i,x_car,y_car,x,y)
    tan_theta = atan2(y(i)-y(i-1), x(i)-x(i-1)); 
    rotation_matrix = [cos(tan_theta), -sin(tan_theta); sin(tan_theta), cos(tan_theta)];
    rect_points = [x_car; y_car];
    rotated = (rotation_matrix * rect_points);
end
