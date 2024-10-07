public class Fatorial {
    public static void main (String[] args){
        int num, fatorial = 1;

        num = 4;

        for(int i=num;i>=1;i--){
            fatorial = fatorial*i;
        }
        System.err.printf("Fatorial do numero %d eh: %d",num,fatorial);
    }
}
