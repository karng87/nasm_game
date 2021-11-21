// Root Formular class of rooT

{
  c1 = new TCanvas("c1", "My Root plots",1000,500);
  c1->Divide(2,1);
  c1->cd(1);
  f1= new TF1("f1", "sin(x)",0,5);
  f1->SetLineColor(kBlue+2);
  f1->Draw();

  f2= new TF1("f2", "cos(x)",0,5);
  f2->SetLineColor(kRed+2);
  f2->SetTitle("cos(x);X(radian); Y(miles)");
  f2->Draw("same");

  c1->cd(2);
  f3= new TF2("f3", "10*sin(x)*cos(y)",-3,3,0,10);
  f3->SetLineColor(kRed+2);
  f3->SetTitle("10*sin(x)*cos(y);X(radian); Y");
  f3->Draw("surf2");

}
