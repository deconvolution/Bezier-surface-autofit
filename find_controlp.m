function K=find_controlp(true_model,K,u_interval,v_interval,alp,iteration,pro)
%%
tic;
u=0:u_interval:1;
v=0:v_interval:1;
[n,m,~]=size(K);
%% forward propagation
%{
figure(1)
ax=scatter3(reshape(K(:,:,1),[size(K,1)*size(K,2),1]),reshape(K(:,:,2),[size(K,1)*size(K,2),1]),reshape(K(:,:,3),[size(K,1)*size(K,2),1]),'o','red');
hold on;
CO=zeros(size(hatN,1),size(hatN,2),3);
CO(:,:,1)=1; % red
CO(:,:,2)=1; % green
CO(:,:,3)=0; % blue
ax2=surf(hatN(:,:,1),hatN(:,:,2),hatN(:,:,3),CO,'facealpha',.5);
hold on;
ax3=plot3(true_model(1,:),true_model(2,:),true_model(3,:),'.','color',[.3,0,1]);
xlabel('x');
ylabel('y');
zlabel('z');
legend([ax,ax2,ax3],'control point','Bizier surface','true surface','location',[.1,.9,.1,.1],'orientation','vertical');
shg;
hold off;
%}
%% cost for each u,v
C2=zeros(iteration,1);
for it=1:iteration
    pC_pK=zeros(size(K,1),size(K,2));
    hatN=zeros(length(u),length(v),3);
    hatN=bezier_surface(K,u_interval,v_interval);
    C=0;
    %%
    for k=1:length(u)
        for l=1:length(v)
            t=nearest(true_model,hatN(k,l,:),1);
            C=C+(hatN(k,l,3)-t(3))^2;
            pC_phatNz=2*(hatN(k,l,3)-t(3));
            phatNz_pK=B(1:n,n,u(k))'*B(1:m,m,v(l));
            pC_pK=pC_pK+pC_phatNz*phatNz_pK;

        end
    end
    C=C/length(u)/length(v);
    C2(it)=C;
    t2=max(pC_pK(:));
    %% plot progress
    if pro==0
        figure(99)
        set(gcf,'position',[0,0,800,700]);
        subplot(2,2,1)
        ax=scatter3(reshape(K(:,:,1),[size(K,1)*size(K,2),1]),reshape(K(:,:,2),[size(K,1)*size(K,2),1]),reshape(K(:,:,3),[size(K,1)*size(K,2),1]),'o','red');
        hold on;
        CO=zeros(size(hatN,1),size(hatN,2),3);
        CO(:,:,1)=1; % red
        CO(:,:,2)=1; % green
        CO(:,:,3)=0; % blue
        ax2=surf(hatN(:,:,1),hatN(:,:,2),hatN(:,:,3),CO,'facealpha',.5);
        hold on;
        ax3=plot3(true_model(1,:),true_model(2,:),true_model(3,:),'.','color',[.3,0,1]);
        xlabel('x');
        ylabel('y');
        zlabel('z');
        legend([ax,ax2,ax3],'control point','Bizier surface','true surface','location',[.1,.9,.1,.1],'orientation','vertical');
        shg;
        hold off;
        
        subplot(2,2,2)
        plot(C2(1:it),'color','blue');
        xlabel('iteration');
        ylabel('cost');
        set(gca,'yscale','log');
        title('cost');
        hold off;
        
        subplot(2,2,3)
        imagesc(pC_pK);
        xlabel('y');
        ylabel('x');
        title({['gradient for K_z'],['max gradient=',num2str(t2/n/m)]});
        colorbar;
        hold off;
        shg;
        print(gcf,['C:\Users\zhang\OneDrive\courses\structural modeling\auto_fit\pic\' num2str(it) '.png'],'-dpng','-r400');
    end
    K(:,:,3)=K(:,:,3)-alp/n/m*pC_pK;
    fprintf('\niteration=%d/%d \n  elapsed time=%fs',it,iteration,toc);
end
%% plot progress
if pro==1
    figure(99)
    set(gcf,'position',[0,0,800,700]);
    subplot(2,2,1)
    ax=scatter3(reshape(K(:,:,1),[size(K,1)*size(K,2),1]),reshape(K(:,:,2),[size(K,1)*size(K,2),1]),reshape(K(:,:,3),[size(K,1)*size(K,2),1]),'o','red');
    hold on;
    CO=zeros(size(hatN,1),size(hatN,2),3);
    CO(:,:,1)=1; % red
    CO(:,:,2)=1; % green
    CO(:,:,3)=0; % blue
    ax2=surf(hatN(:,:,1),hatN(:,:,2),hatN(:,:,3),CO,'facealpha',.5);
    hold on;
    ax3=plot3(true_model(1,:),true_model(2,:),true_model(3,:),'.','color',[.3,0,1]);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    legend([ax,ax2,ax3],'control point','Bizier surface','true surface','location',[.1,.9,.1,.1],'orientation','vertical');
    shg;
    hold off;
    
    subplot(2,2,2)
    plot(C2(1:it),'color','blue');
    xlabel('iteration');
    ylabel('cost');
    set(gca,'yscale','log');
    title('cost');
    hold off;
    
    subplot(2,2,3)
    imagesc(pC_pK);
    xlabel('y');
    ylabel('x');
    title({['gradient for K_z'],['max gradient=',num2str(t2/n/m)]});
    colorbar;
    hold off;
    shg;
end
%% plot final result
figure(100)
ax=scatter3(reshape(K(:,:,1),[size(K,1)*size(K,2),1]),reshape(K(:,:,2),[size(K,1)*size(K,2),1]),reshape(K(:,:,3),[size(K,1)*size(K,2),1]),'o','red');
hold on;
CO=zeros(size(hatN,1),size(hatN,2),3);
CO(:,:,1)=1; % red
CO(:,:,2)=1; % green
CO(:,:,3)=0; % blue
ax2=surf(hatN(:,:,1),hatN(:,:,2),hatN(:,:,3),CO,'facealpha',.5);
hold on;
ax3=plot3(true_model(1,:),true_model(2,:),true_model(3,:),'.','color',[.3,0,1]);
xlabel('x');
ylabel('y');
zlabel('z');
legend([ax,ax2,ax3],'control point','Bizier surface','true surface','location',[.1,.9,.1,.1],'orientation','vertical');
shg;
end