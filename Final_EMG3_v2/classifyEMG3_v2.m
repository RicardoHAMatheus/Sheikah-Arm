function label = classifyEMG3_v2(X) %#codegen
%classifyEMG3final Classificador usando modelo SVM
%   classifyEMG3final classifica os dados em X
%   utilizando modelo SVM carregado no arquivo SVM3.mat
%   e retorna a classe de rotulos em label

CompactMdl = loadLearnerForCoder('SVM3_v2');
label = predict(CompactMdl, X);
end