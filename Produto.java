public class Produto {
	public static void main(String[] args) {
		int num = 1;
		for(int i=1; i<= 13; i+=2){
		num = num*(i*(i+2));
		}
		System.out.println("Produto dos numeros impares de 1 a 15: "+num);
	}
}
