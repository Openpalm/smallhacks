package group23.u03;

import java.util.Random;
/**
 *
 * Created by iddqd on 11/14/16.
 * writing own array generator.
 * faster than learning to use the one afforded.
 *
 * usage example in a main
 *
 * init call ArrayGenHelper(size, lower bound, upper bound)
 * ex:

        ArrayGenHelper gen = new ArrayGenHelper(10, 1, 10);
        Double[] arr = new Double[gen.size()];
        System.arraycopy(gen.getCopy(), 0, arr,0, gen.size());

        for (Integer i = 0; i < arr.length; i++) {
            if (i % 3 == 0) {
                System.out.println();
            }
            System.out.print(arr[i] + " ");
        }

 *
 */
public class ArrayGenHelper {

    private Integer lb = 0;
    private Integer ub = 0;
    private Integer eNr = 0;
    private Double[] array;

//  http://algs4.cs.princeton.edu/11model/Knuth.java.html
//  The Knuth (or Fisher-Yates) shuffling algorithm
//  @author Robert Sedgewick
//  @author Kevin Wayne

    private static void shuffle(Double[] a) {
        int n = a.length;
        for (int i = 0; i < n; i++) {
            // choose index uniformly in [i, n-1]
            int r = i + (int) (Math.random() * (n - i));
            Double swap = a[r];
            a[r] = a[i];
            a[i] = swap;
        }
    }
    private Double randDouble  () {
        Random r = new Random();
        double randomValue = this.lb + (ub - lb) * r.nextDouble();
        return randomValue;
    }
    private void generate() {
        for (Integer i = 0; i < eNr; i++) {
            array[i] = randDouble();
        }
    }

// public section start
    public ArrayGenHelper(Integer elemNr, Integer lowerbound, Integer upperbound) {
        this.lb = lowerbound;
        this.ub = upperbound;
        this.eNr = elemNr;
        this.array = new Double[this.eNr];
        generate();
    }
    public Integer size() {
        return eNr;
    }
    public Double[] getCopy() {
        return array.clone();
    }
    public void shuffle() {
        shuffle(this.array);
    }
}
