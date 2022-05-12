require 'raabro'

module Somador include Raabro
  def num(i);rex(:num, i, /-?[0-9]+/); end

  def mais(i); rex(:mais, i, /\+/); end
  def menos(i); rex(:menos, i, /\-/); end
  def mult(i); rex(:mult, i, /\*/); end
  def divi(i); rex(:divi, i, /\//); end
  def poten(i); rex(:poten, i, /\^/); end
  def apar(i); rex(:apar, i, /\(/); end
  def fpar(i); rex(:fpar, i, /\)/); end
  
  def soma(i); seq(:soma, i, :j, :mais, :e); end
  def diferenca(i); seq(:diferenca, i, :j, :menos, :e); end
  def paren(i); seq(:paren, i, :apar, :e, :fpar); end
  def multiplicacao(i); seq(:multiplicacao, i, :p, :mult, :j); end
  def divisao(i); seq(:divisao, i, :p, :divi, :j); end
  def potencia(i); seq(:potencia, i, :p, :poten, :j); end
  
  def secun(i); alt(:secun, i, :soma, :diferenca); end
  def first(i); alt(:secun, i, :multiplicacao, :divisao, :potencia); end
  
  def e(i); alt(:e, i, :secun, :j); end
  def j(i); alt(:j, i, :first, :p); end
  def p(i); alt(:p, i, :paren, :num); end
  
  def expressao(i); alt(:expressao, i, :soma, :diferenca, :multiplicacao, :divisao, :potencia, :paren); end

  def rewrite_num(t); "Reconhecido NUM: " + t.string; end
  
  def rewrite_mais(t); "Mais (+)"; end
  def rewrite_menos(t); "Menos (-)"; end
  def rewrite_mult(t); "Multiplicação (*)"; end
  def rewrite_divi(t); "Divisão (/)"; end
  def rewrite_poten(t); "Potência (^)"; end
  def rewrite_apar(t); "Abre parenteses("; end
  def rewrite_fpar(t); "Fecha parenteses )"; end
    
  def rewrite_expressao(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append("Reconhecido Expressão")
  end

  def rewrite_soma(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append("Reconhecido Soma")
  end

  def rewrite_paren(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append("Reconhecido Parenteses")
  end

  def rewrite_diferenca(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append("Reconhecido Diferença")
  end

  def rewrite_multiplicacao(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append("Reconhecido Multiplicação")
  end

  def rewrite_divisao(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append("Reconhecido Divisão")
  end

  def rewrite_potencia(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append("Reconhecido Potência")
  end

  def rewrite_e(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append()
  end

  def rewrite_j(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append()
  end

  def rewrite_p(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append()
  end

  def rewrite_secun(t)
    folhas = t.children 
    folhas.collect { |e| rewrite(e)}.append()
  end
end

puts Somador.parse("(1+4)*2^4", error: true)
puts
puts Somador.parse("7/(1-3)", error: true)
puts
puts Somador.parse("9^(1*6/2+4)", error: true)
puts 
puts Somador.parse("2+4^-4/4", error: true)
puts
puts
puts
puts 
puts Somador.parse("^2+4", error: true)
puts
puts Somador.parse("9*2+", error: true)
puts
puts Somador.parse("9++3", error: true)
puts
puts Somador.parse("()*3", error: true)
puts
puts Somador.parse("(3+3)", error: true)