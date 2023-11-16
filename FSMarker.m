function row = FSMarker(x,y)
    [b,fitinfo] = lasso(x,y,'CV',10); % 参数初始化
    axTrace = lassoPlot(b,fitinfo); %交叉验证训练轨迹
    axCV = lassoPlot(b,fitinfo,'PlotType','CV');
    lam = fitinfo.IndexMinMSE;  % 最小MSE对应lambda
    mat = b(:,lam);             % 最优lambda对应的稀疏系数
    [row, ] = find(b(:,lam)~=0);% 非零系数对应的行
    Xla = x(:, row');           % 筛选稀疏变量
%     save data_FSMarker.mat lam 
%     %MIC SELECT
%     N = size(Xla,2);
%     micMat=zeros(N,N);
%     micMat=micMat+eye(N,N);
%     %求特征两两之间的相关性大小
%     for i=1:(N-1)
%         for j=(i+1):N
%             rTemp = mine(Xla(:,i)',Xla(:,j)');
%             micTemp = rTemp.mic;
%             micMat(i,j)= micTemp;
%             micMat(j,i)=micTemp;
%         end
%     end
%     %求特征与标签之间的相关性大小
%     micMatY = zeros(1,N);
%     for i  = 1:N
%         t = mine(Xla(:,i)',y');
%         micMatY(i) = t.mic;
%     end
%     %根据近似马尔可夫毯去除冗余特征
%     for i=1:(N-1)
%         for j=(i+1):N
%            if(micMatY(i) > micMatY(j) && micMat(i,j) > micMatY(j))
%                row(j) = 0;
%            end
%         end
%     end
% row1 = row(find(row~=0))
end