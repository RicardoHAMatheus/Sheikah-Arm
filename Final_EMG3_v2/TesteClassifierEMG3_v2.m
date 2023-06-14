clear all;

install_myo_mex;
build_myo_mex C:\myo-sdk-win-0.9.0\

mm = MyoMex()
pause(5)
%% 

for k=1:inf
    % Pega o log de sinais a cada 1.5 segundos
    pause(1.5);
    m = mm.myoData.emg_log;
    
    % Confere os ultimos 5 segundos do log 
    mt = m(end-875:end-375,:);
    
     % Transforma o sinal 
    mt2 = mt.*mt;
    
    mt3 = mt2./abs(mt);

    mt4 = mt3;

    mt4(isnan(mt4))=0;
    
    % Classifica o sinal (classificador)
    respm2 = classifyEMG3_v2(mt4);
    
    [s,~,j] = unique(respm2);

    % Movimento que foi lido mais vezes
    pdt2 = s{mode(j)}
    
    % Repetições de cada movimento lido no intervalo, e suas porcentagens
    y = groupcounts(respm2);
    % Porcentagem do movimento mais lido
    y_m = sum(y,"all");
    y_2 = max(y,[],1);
    prt = (y_2/y_m)*100;
    
    % Confere o movimento e se ele apareceu mais de 25% das vezes no sinal
    if (prt>=25)
        if (isequal(pdt2, 'mao_fechada'))
            disp('modelo mudou para mão fechada')
            pause(0.5);
        end
        
        if isequal(pdt2, 'indicador')
            disp('modelo mudou para indicador')
            pause(0.5);
        end
        
        if isequal(pdt2, 'mao_aberta')
            disp('modelo mudou para mão aberta')
            pause(0.5);
        end
        
        if isequal(pdt2, 'pinca')
            disp('modelo mudou para pinca')
            pause(0.5);
        end
        
        if isequal(pdt2, 'polegar')
            disp('modelo mudou para polegar')
            pause(0.5);
        end
    else
        disp('nenhum movimento com 25%+ de ocorrencias')
    end
end