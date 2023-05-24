%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% File to plot experimental bacterial count data given in: 
% 2023 - Pedreira et al - Modelling the antimicrobial effect of food
%                         preservatives in bacteria: application to 
%                         E. coli and B. cereus inhibition with carvacrol
%=========================================================================%

%==========================================================================
% Figure general settings
%==========================================================================
set(0,'defaultTextInterpreter','latex');                                   % Define latex as text interpreter for figure
for_all = 'axis tight;hold on;box off;';                                   % Axis general settings
cols    = [{'k'},{'r'},{'b'},{[.5 .5 0]},{'g'},{'m'},{'y'}];               % Define colors
bac_ii  = {'Bc','Ec'};                                                     % Define names of bacterial strains ('Bc' = B. cereus and 'Ec' = E. coli)
bac_t   = {'\textit{Bacillus cereus}','\textit{Escherichia coli}'};        % Define titles for plot

f{1}=figure;                                                               % Set position in window of first figure
set(gcf,'OuterPosition',[624   214    1073   837])


%==========================================================================
% Plot OD and CFUs/mL data for each bacterial strain
%==========================================================================
for ibac = 1:2                                                             % For loop on the bacterial strains
    
    % Select type of bacteria:
    %-----------------------------------------------------------------
    bac = bac_ii{ibac};
    
    % Load experimental data:
    %-----------------------------------------------------------------
    load(['./Generated_data/data_',bac])
    
    % Plot data for each carvacrol concentration:
    %-----------------------------------------------------------------
    for iexp = 1:6
        
        x = X_OD{iexp};                                                    % Optical density data
        y = X_cfus{iexp};                                                  % CFUS/mL data
        t = tt{iexp};                                                      % Experimental times
        
        figure(f{1})
        
        % Plot OD data:
        %-----------------------------------------------------------------
        subplot(3,2,1+(ibac-1))                                 
        plot(t,x,'.','color',cols{iexp},'MarkerSize',14,'HandleVisibility','off')
        eval(for_all);
        
        % Plot error associated with OD measurements:
        %-----------------------------------------------------------------
        subplot(3,2,1+(ibac-1))
        errorbar(t,x,Ei_OD(:,iexp),'color',cols{iexp})                     
        eval(for_all);
        ylabel('OD');
        xlabel('Time (h)');
        title(bac_t{ibac});
        
        % Build and display legend:
        %-----------------------------------------------------------------
        if iexp == 6 && ibac == 2                                          
            legend([{[num2str(0),'mg/L']},...
                {[num2str(50),'mg/L']},...
                {[num2str(75),'mg/L']},...
                {[num2str(100),'mg/L']},...
                {[num2str(150),'mg/L']},...
                {[num2str(200),'mg/L']}],...
                'Position',[0.127621722360293 0.0229031649823179 0.75033602895228 0.0258962322171771],...
                'Orientation','horizontal');
            legend show
        end
        
        % Plot log10(CFUS/mL) data:
        %-----------------------------------------------------------------
        figure(f{1})                                                       
        subplot(3,2,3+(ibac-1))
        
        plot(t,log10(y),'.','color',cols{iexp},'MarkerSize',14)            
        eval(for_all);
        ylabel('$\log_{10}$(CFUs/mL)');xlabel('Time (h)')
        
        subplot(3,2,5+(ibac-1))
        plot(t,y,'.','color',cols{iexp},'MarkerSize',14)
        eval(for_all);
        ylabel('CFUs/mL');xlabel('Time (h)')
        
        % Plot error associated with log10(CFUS/mL) measurements:
        %-----------------------------------------------------------------  
        figure(f{1})
        subplot(3,2,3+(ibac-1))
        errorbar(t,log10(y),E_log_cfus{iexp},'color',cols{iexp})
        eval(for_all);
        
        subplot(3,2,5+(ibac-1))
        errorbar(t,y,Ei_cfus(:,iexp),'color',cols{iexp})
        eval(for_all);
        
    end
    
    % Build and display legend:
    %-----------------------------------------------------------------
    if iexp == 6 && ibac == 2
        legend([{[num2str(0),'mg/L']},...
                {[num2str(50),'mg/L']},...
                {[num2str(75),'mg/L']},...
                {[num2str(100),'mg/L']},...
                {[num2str(150),'mg/L']},...
                {[num2str(200),'mg/L']}],...
                'Position',[0.127621722360293 0.0229031649823179 0.75033602895228 0.0258962322171771],...
                'Orientation','horizontal');
    end
    
    
end

%==========================================================================
% Save figures
%==========================================================================
savefig('./Generated_results/fig_SubMIC_Carvacrol_Data')
