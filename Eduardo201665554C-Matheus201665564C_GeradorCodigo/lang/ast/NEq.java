/* Eduardo Vieira Marques Pereira do Valle 201665554C
 * Matheus Brinati Altomar 201665564C
 */
package lang.ast;

import lang.visitors.Visitor;

public class NEq extends BinOP {

    public NEq(int li, int c, Expr l, Expr r) {
        super(li, c, l, r);
    }

    public void accept(Visitor v) {
        v.visit(this);
    }
}
