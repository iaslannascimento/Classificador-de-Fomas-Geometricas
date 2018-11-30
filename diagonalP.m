%Função que conta a quantidade de pixels do objeto na diagonal principal da imagem
function cont = diagonalP(im)
  cont = 0;
  for j=1:size(im, 1)
    for k=1:size(im, 2)
      if(j==k && im(j,k)==1) %Se for um pixel do objeto e estiver na diagonal então contabiliza-o
        cont++;
      end
    end
  end 
end