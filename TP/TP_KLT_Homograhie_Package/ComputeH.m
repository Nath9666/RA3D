function H = ComputeH (p3d, p2d)

% p3d : coordonnées 3d des coins de la cible planaire
% p2D : les points images (en pixels) correspondant aux points 3D


for i=1:size(p3d,1)
    A(2*i-1:2*i,:)=[
    p3d(i,1) p3d(i,2)  1 0 0 0 -p2d(i,1)*p3d(i,1) -p2d(i,1)*p3d(i,2)     
    0 0 0  p3d(i,1) p3d(i,2) 1 -p2d(i,2)*p3d(i,1) -p2d(i,2)*p3d(i,2)   
    ];
    b(2*i-1:2*i,:)=[
          p2d(i,1)
          p2d(i,2)
          ];
end

%x=inv(A)*b;

x=pinv(A'*A)*A'*b;

h1 = [x(1) x(4) x(7)]';
h2 = [x(2) x(5) x(8)]';
h3 = [x(3) x(6) 1]';
H  = [h1 h2 h3];
end