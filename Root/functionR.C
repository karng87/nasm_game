void functionR(){
  TF1 *f = new TF1("f1","x*(x-2)",0,10);
  f->Draw();
  cout << f->Eval(22.2) << endl;
}
