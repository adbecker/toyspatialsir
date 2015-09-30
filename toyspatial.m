clear all
close all


N = 100;
beta = 1;
gamma = 1;
b = 1e-2;
mu = b;

dt = 0.1;
tmax = 30;
trange = tmax/dt;

S = round(rand(N,N));
I = zeros(N);
R = I;
one.infec = randsample(find(S==0),1);
I(one.infec) = 1;

%writerObj = VideoWriter('SpatialSIR.gif'); % Name it.
%writerObj.FrameRate = 30; % How many frames per second.
%open(writerObj); 


for t=1:trange
    
colormap('hot')
imagesc(I)
title(['Spatial SIR with Birth - Infected Class, time: ' num2str(t*dt)] )
xlabel('Spatial co-ordinate (x)')
ylabel('Spatial co-ordinate (y)')
caxis([0,1])
colorbar
drawnow
    
  for i=2:(N-1)
  for j=2:(N-1)
      
    trans = beta * S(i,j) * (I(i-1,j+1)+I(i-1,j)+I(i-1,j-1)+I(i,j+1)+I(i,j-1)+I(i+1,j+1)+I(i+1,j)+I(i+1,j-1));
    infec = gamma * I(i,j);
    birth = b * (S(i,j) + I(i,j) + R(i,j));
    
    S(i,j) = S(i,j) + dt*(birth - trans - mu * S(i,j));
    I(i,j) = I(i,j) + dt*(trans - infec - mu * I(i,j));
    R(i,j) = R(i,j) + dt*(infec - mu * R(i,j));
 
  end
  end
  
   %frame = getframe(gcf); % 'gcf' can handle if you zoom in to take a movie.
   %writeVideo(writerObj, frame);

end

%close(writerObj); % Saves the movie.



