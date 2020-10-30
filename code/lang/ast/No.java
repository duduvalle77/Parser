/* Eduardo Vieira Marques Pereira do Valle 201665554C
 * Matheus Brinati Altomar 201665564C
 */
package lang.ast;
import org.antlr.v4.runtime.tree.*;

public class No extends SuperNode{

    protected ParseTree tree;

    public ParseTree getTree()
    {
        return tree;
    }

    public void setTree(ParseTree tree2)
    {
        tree = tree2;
    }

    public int getLine()
    {
        return 0;
    }

    public int getColumn()
    {
        return 0;
    }
}
