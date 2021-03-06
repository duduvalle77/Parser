/* Eduardo Vieira Marques Pereira do Valle 201665554C
 * Matheus Brinati Altomar 201665564C
 */
package lang;

import lang.parser.*;
import lang.visitors.*;

public class LangCompiler{
   // Recupera o nome base (sem extensão) de um arquivo.
   public static void main(String[] args){
       if( args.length < 1 ){
          System.out.println("Lang compiler v 0.0.1 - Maio de 2020");
          System.out.println("Use java -cp . Lang ação <Caminho para código Fonte> ");
          System.out.println("Ação (uma das seguintes possibilidades): ");
          
          System.out.println(" -bs : Executa uma bateria de testes sintáticos");
          System.out.println(" -bty : Executa uma bateria de testes no sistemas de tipos");
          System.out.println(" -bsm : Executa uma bateria de testes no interpretador");
          System.out.println(" -bgc : Executa uma bateria de testes no interpretador");          
          
       }
       try{
	   ParseAdaptor langParser = new ControlParser();
          
          if(args[0].equals("-bs") ){
              System.out.println("Executando bateria de testes sintáticos:");
              TestParser tp = new TestParser(langParser);
              return;
          }if(args[0].equals("-byt") ){
              System.out.println("Executando bateria de testes sintáticos:");
              TestType tt = new TestType(langParser);
              return;
          } if(args[0].equals("-bsm") ){
              System.out.println("Executando bateria de testes de interpretador:");
              //TestInterpretador in = new TestInterpretador(langParser); 
              return;
          } if(args[0].equals("-bgc") ){
            System.out.println("Executando bateria de testes de interpretador:");
            TestCompilador gc = new TestCompilador(langParser); 
            return;
          } else {
            System.out.println("Comando nao existente:");
          }
      }catch(Exception e){
          e.printStackTrace();
      }
   }
}
 
