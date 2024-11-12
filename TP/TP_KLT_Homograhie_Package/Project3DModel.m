function h = Project3DModel(img, K, R_opt, T_opt, cube3d)


rotation = R_opt;
translation = T_opt;


c_3d = K*(rotation*cube3d' + translation);
c_2d = c_3d(1:2,:)./repmat(c_3d(3,:),[2,1]);
h = figure;
imshow(img);
hold on;
scatter(c_2d(1,:)', c_2d(2,:)', 15,'r');
 
imm = c_2d;
line (imm(1,1:4),imm(2,1:4),'LineWidth',4, 'Color','red');
x=[imm(1,4) imm(1,1)];
y=[imm(2,4) imm(2,1)];
line(x,y,'LineWidth',4, 'Color','red');

line (imm(1,5:8),imm(2,5:8),'LineWidth',4, 'Color','red');
x=[imm(1,8) imm(1,5)];
y=[imm(2,8) imm(2,5)];
line(x,y,'LineWidth',4, 'Color','red');

x=[imm(1,1) imm(1,5)];
y=[imm(2,1) imm(2,5)];
line(x,y,'LineWidth',4, 'Color','red');

x=[imm(1,2) imm(1,6)];
y=[imm(2,2) imm(2,6)];
line(x,y,'LineWidth',4, 'Color','red');

x=[imm(1,3) imm(1,7)];
y=[imm(2,3) imm(2,7)];
line(x,y,'LineWidth',4, 'Color','red');

x=[imm(1,4) imm(1,8)];
y=[imm(2,4) imm(2,8)];
line(x,y,'LineWidth',4, 'Color','red');

end
 