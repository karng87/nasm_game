void histogram(){
  TH1D *hist = new TH1D("name","title;x;n", 10,0,20);
  hist->Fill(1);
  hist->Fill(2);
  hist->Fill(1);
  hist->Fill(1);
  hist->Fill(1);
  hist->Draw();
}
