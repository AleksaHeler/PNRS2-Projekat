
class klasa_rand;  // definicija klase
  rand  logic [7:0] podatak;
  rand  logic selektor; 
  
  function void pre_randomize();
    //$display("ispis u pre_randomize selektor = %0d, \t podatak = %0d; ", selektor, podatak);
  endfunction

  function void post_randomize();
    //$display("ispis u post_randomize selektor = %0d, \t podatak = %0d; ", selektor, podatak);
  endfunction
  
  constraint Con1;
  constraint Con2;
  constraint Con3;
  constraint Con4;
endclass // klasa_rand
  constraint klasa_rand::Con1 {selektor dist {0:=10, 1:=1};}
  constraint klasa_rand::Con2 {selektor == 0 -> podatak < 128 ; selektor == 1 -> podatak >= 128 ;}
  constraint klasa_rand::Con3 {selektor == 1 -> podatak > 200 ;}  // Zad1: dodato ogranicenje
  constraint klasa_rand::Con4 {selektor == 0 -> podatak > 128 ;}  // Zad1: dodato ogranicenje

module rand_tb;

  byte podatak;
  bit selektor;

  logic [4:0] k; // loop varijabla
  integer seed = 123;
  
  klasa_rand rand_obj; // deklaracija objekta date klase
  
  covergroup CovGrp;
    coverpoint selektor;
    coverpoint podatak {
      bins sve_nule = {'b000000000};
      bins niske_vr = {['b000000001:'b01111111]};
      bins visoke_vr = {['b10000000:'b11111110]};
      bins sve_jedinice  = {'b111111111};
      bins tranzicija_0_20_30  = (0 => 20 => 30);
      bins skup_tranzicija[]  = (10,15 => 20,25);
    }
    cross selektor, podatak;
  endgroup

  CovGrp my_covergroup;

  initial begin
    my_covergroup = new();
    rand_obj = new(); // konstrukcija objekta

    repeat(100) begin // repeat everything
      // Postavljanje istog 'seed'-a za prvih 8 iteracija
      //rand_obj.srandom(seed);
      for (k=0; k <= 7; k++) begin
        // postavljanje ogranicenja
        rand_obj.Con1.constraint_mode(k[0]);
        rand_obj.Con2.constraint_mode(k[1]);
        rand_obj.Con3.constraint_mode(k[2]);
        rand_obj.Con4.constraint_mode(k[3]);
        $display ("Con : %b  %b  %b  %b", k[0], k[1], k[2], k[3]);
        repeat(5) begin
        if(rand_obj.randomize()) begin
          $display(" Randomizacija uspesna, selektor = %0d, \t podatak = %0d; ", rand_obj.selektor, rand_obj.podatak);
          selektor = rand_obj.selektor;
          podatak = rand_obj.podatak;
          my_covergroup.sample();
        end
        else
          $display(" Randomizacija neuspesna!");
        end
        $display ("--------------------------------------------------------------------");
      end // for loop

      // Postavljanje istog 'seed'-a za drugih 8 iteracija
      //rand_obj.srandom(seed);
      for (k=8; k <= 15; k++) begin
        // postavljanje ogranicenja
        rand_obj.Con1.constraint_mode(k[0]);
        rand_obj.Con2.constraint_mode(k[1]);
        rand_obj.Con3.constraint_mode(k[2]);
        rand_obj.Con4.constraint_mode(k[3]);
        $display ("Con : %b  %b  %b  %b", k[0], k[1], k[2], k[3]);
        repeat(5) begin
        if(rand_obj.randomize()) begin
          $display(" Randomizacija uspesna, selektor = %0d, \t podatak = %0d; ", rand_obj.selektor, rand_obj.podatak);
          selektor = rand_obj.selektor;
          podatak = rand_obj.podatak;
          my_covergroup.sample();
        end
        else
          $display(" Randomizacija neuspesna!");
        end
        $display ("--------------------------------------------------------------------");
      end // for loop
    end // repeat everything

  end // initial begin
endmodule // rand_tb
