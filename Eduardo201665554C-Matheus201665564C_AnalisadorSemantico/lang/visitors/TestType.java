/* Eduardo Vieira Marques Pereira do Valle 201665554C
 * Matheus Brinati Altomar 201665564C
 */
package lang.visitors;

import java.io.*;
import lang.ast.*;
import lang.parser.*;
// Adaptador para classe de parser. a Função parseFile deve retornar null caso o parser resulte em erro. 

public class TestType {
   private ParseAdaptor adp;
   private String okSrcs = "testes/sintaxe/certo/";
   private File f;
   
   public TestType(ParseAdaptor adp){
        this.adp = adp;
        f = new File(okSrcs);
        runOkTests();
   }
   
   private String filler(int n){
      String s = "";
      for(int i =0; i< n; i++){ s += " "; }
      return s;
   }
   
   public void runOkTests(){
       File inst[];
       int flips, flops;
       flips = 0;
       flops = 0;
       try{
           if( f.isDirectory() ){
               String pth;
               inst = f.listFiles();
               for(File s : inst){
                   pth = s.getPath();
                   System.out.print("Testando " + pth + filler(50 -pth.length()) + " ");
                   SuperNode aux = adp.parseFile(s.getPath());
                   if(aux != null){
                       Visitor v = new TypeVisitor();
                       aux.accept(v);
                       System.out.println("OK");
                       flips++;
                   }else{ 
                      System.out.println("FALHOU");
                      flops++;
                   }
               }
               System.out.println("Total de acertos: " + flips );
               System.out.println("Total de erros: " + flops );
           }else{
              System.out.println("O caminho " + f.getPath() + " não é um diretório ou não existe.");
           }
           
       }catch(Exception e){
           e.printStackTrace();
       }
   }
}

