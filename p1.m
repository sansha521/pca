load('teapots.mat')
data = teapotImages;

% mean
u = mean(data);     % compute mean

figure(1);          % execute image
colormap gray;
subplot(1,2,1);
imagesc(reshape(u(1,:), 38, 50));
axis image;


% eigenvector and eigenvals
X = data - u;       % compute subset 
C = cov(X);         % covariance matrx
[V, D] = eig(C);    % eigenvector matrix V and eigenvalue matrix D
[d, ind] = sort(diag(D),'descend');     % eigenvalues in descending order
d = d(1:3,:);       % find top 3 eigenvectors
v = V(:,ind(1:3));  % take top 3 eigenvalues
fprintf('eigenvals = %f\n', v);

% eigenval1
figure(2);
colormap gray;
subplot(1,2,1);
imagesc(reshape(v(:,1),38,50));   % 1st vector with eigenvalue=4.2150
axis image;

% eigenval2
figure(3);
colormap gray;
subplot(1,2,1);
imagesc(reshape(v(:,2),38,50));   % 2nd vector with eigenvalue=3.0168
axis image;

% eigenval3
figure(4);
colormap gray;
subplot(1,2,1);
imagesc(reshape(v(:,3),38,50));   % 3rd vector with eigenvalue=2.0993
axis image;


% PCA
c = X*v;            % coefficient matrix
X_hat = u+c*v';     % reconstruct x

% generate 10 images
for i = 1:10
    figure(i);
    colormap gray;
    subplot(1,2,1);
    imagesc(reshape(data(i,:),38,50));
    title('Original');
    axis image;
    subplot(1,2,2)
    imagesc(reshape(X_hat(i,:),38,50));
    title('PCA');
    axis image;
end

norm(data-X_hat)


% extra PCA
[d1, ind] = sort(diag(D),'descend');     % eigenvalues in descending order
d1 = d1(1:32,:);       % find top 32 eigenvectors
v1 = V(:,ind(1:32));   % take top 32 eigenvalues

c1 = X*v1;             % coefficient matrix
X_hat1 = u+c1*v1';     % reconstruct x

i = 5                  % generate image
figure(i);
colormap gray;
subplot(1,2,1);
imagesc(reshape(data(i,:),38,50));
title('Original');
axis image;
subplot(1,2,2)
imagesc(reshape(X_hat(i,:),38,50));
title('Extra PCA');
axis image;