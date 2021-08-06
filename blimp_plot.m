function blimp_plot(state, num_plot, size_map)
% state: the 3 DOF state vector with respect to the center of gravity.
%         state(1): px_n
%         state(2): vx_b
%         state(3): pz_n
%         state(4): vz_b
%         state(5): pitch
%         state(6): omega
% num_plot:the number of figure
% size_map: 6 by 1 vector: [x_l; x_u; y_l; y_u; z_l; z_u]

    figure(num_plot);
    clf;
    s = size_map;
    xlim([s(1),s(2)])
    ylim([s(3),s(4)])
    zlim([s(5),s(6)]);
    set(gca,'YDir','reverse');  
    set(gca,'ZDir','reverse');  
    xlabel('x')
    ylabel('y')
    zlabel('z')
    hold on;
    
    % plot the ground boundaries and the big cross
    plot3([s(1) s(2)],[s(3) s(3)],[s(6) s(6)],'-b')
    plot3([s(1) s(1)],[s(3) s(4)],[s(6) s(6)],'-b')
    plot3([s(2) s(2)],[s(4) s(3)],[s(6) s(6)],'-b')
    plot3([s(2) s(1)],[s(4) s(4)],[s(6) s(6)],'-b')
    plot3([s(1) s(2)],[s(3) s(4)],[s(6) s(6)],'-b')
    plot3([s(1) s(2)],[s(4) s(3)],[s(6) s(6)],'-b')
    plot3(0,0,s(5));
    plot3(0,0,s(6));
    grid on;    
    
    % state paremeters
    px_cg = state(1);
    py_cg = 0;
    pz_cg = state(3);
    roll = 0;
    pitch = state(5);
    yaw = 0;
    rotx = [1, 0, 0; 0, cos(roll), -sin(roll); 0, sin(roll), cos(roll)];
    roty = [cos(pitch), 0 sin(pitch); 0, 1, 0; -sin(pitch), 0, cos(pitch)];
    rotz = [cos(yaw), -sin(yaw), 0; sin(yaw), cos(yaw), 0; 0, 0, 1];
    rot_matrix = rotz * roty * rotx;
    rz = 0.09705; %r_(z,g/b)^b
    p_bg_g = [0;0;-rz];
    
    % draw the center of gravity
    plot3(px_cg, py_cg, pz_cg,'ob')
    
    % draw the center of buoyancy
    p_b = rot_matrix * p_bg_g + [px_cg; py_cg; pz_cg];
    plot3(p_b(1), p_b(2), p_b(3),'or');
    
    %
    plot3([px_cg, p_b(1)],[py_cg,p_b(2)],[pz_cg,p_b(3)],'-b')
%     % draw the xz outline
%     outline_xz_b_2D = ellipse(0.63/2,0.4/2);
%     outline_xz_b_3D = zeros(3, size(outline_xz_b_2D,2));
%     outline_xz_b_3D(1,:) = outline_xz_b_2D(1,:);
%     outline_xz_b_3D(3,:) = outline_xz_b_2D(2,:);
%     outline_xz_n = rot_matrix * outline_xz_b_3D + p_b;
%     plot3(outline_xz_n(1,:), outline_xz_n(2,:), outline_xz_n(3,:),'b');
%     
%     % draw the yz outline
%     outline_yz_b_2D = ellipse(0.63/2,0.4/2);
%     outline_yz_b_3D = zeros(3, size(outline_yz_b_2D,2));
%     outline_yz_b_3D(2,:) = outline_yz_b_2D(1,:);
%     outline_yz_b_3D(3,:) = outline_yz_b_2D(2,:);
%     outline_yz_n = rot_matrix * outline_yz_b_3D + p_b;
%     plot3(outline_yz_n(1,:), outline_yz_n(2,:), outline_yz_n(3,:),'b');
    
    % draw the xy outline
    r = 0.63/2;
    outline_xy_b_2D = circle(0.63/2);
    outline_xy_b_3D = zeros(3, size(outline_xy_b_2D,2));
    outline_xy_b_3D(1,:) = outline_xy_b_2D(1,:);
    outline_xy_b_3D(2,:) = outline_xy_b_2D(2,:);
    outline_xy_n = rot_matrix * outline_xy_b_3D + p_b;
    plot3(outline_xy_n(1,:), outline_xy_n(2,:), outline_xy_n(3,:),'b');
    
    % draw the arrow pointing to the heading direction
    arrow3(p_b', (3 * rot_matrix * outline_xy_b_3D(:,1) + p_b)', '0.1_b')
    
    % draw the center of gravity on the ground plane
    plot3([px_cg (s(1)+s(2))/2],[py_cg (s(3)+s(4))/2],[s(6) s(6)],'--k')
    plot3([px_cg],[py_cg],[s(6)],'xk')
    view(3)
    
    axis equal
end