// This Game Was Programmed By Ryan Woodford, A.K.A CyberSpike
// If You Wish To Use This Code For Any Purpose Please Give Credit

#include <iostream>
#include <cctype>
using namespace std;

int Hp;
int HpMax;
int Atk;
int Def;
int Exp;
int ExpMax;
int Gold;
int Eatk;
int EDef;
int EMaxHp;
int EHp = EMaxHp;
int EGold;
int EExp;
int Batk;
int BDef;
int BMaxHp = 1;
int BHp = 1;
int BExp;
int BGold;
int Boss = 1;
void Welcome();
void Story();
void Wake();
void Points();
void Stat();
void Fight();
void FightLaunch();
void FightProcess();
void Outside();
void Inn();
void Forest();
void Temple();
void Boss1();
void BossFight();
void BossLaunch();
void BossProcess();
char Job;
char Pick;

int main()
{
	system("cls");
	Welcome();
	Story();
	Wake();
	Points();
	Stat();
	Inn();

}


void Welcome()
{

	cout << " --------------------------------- " << endl;
	cout << "\n|       Other World Fantasy     | " << endl;
	cout << "\n--------------------------------- " << endl;
	cout << "\nThis Game Was Programmed By Ryan Woodford , CyberSpike " << endl;
	system("pause");
	system("cls");
	
	return;

}

void Story()
{
	cout << " --------------------------------- " << endl;
	cout << "\n|       Other World Fantasy     | " << endl;
	cout << "\n--------------------------------- " << endl;
	cout << "\n" << "\n" << endl;
	cout << "	A long time ago, in a realm of medieval magic, weapons and warriors... " << endl;
	cout << "\nA great demon was summoned from hell to bring ruin to the kingdom of Shanook... " << endl;
	cout << "\nMany brave knights rose to banish this demon..." << endl;
	cout <<"\nBut all have failed..." << endl;
	cout <<"\nWho Will Stop This Savage Beast?" << endl;
	system("pause");
	system("cls");

	return;
}

void Wake()
{
	cout << "You Awaken Very Slowly, You Begin Cursing Hangovers And Every Form Of Booze..." << endl;
	cout << "Your Head Is Splitting And You Can Remember A Thing, Where Or Who You Are." << endl;
	system("pause");
	system("cls");
	cout << "As You Climb To You Feet You Realize Your Staying At The Old Overnighter. An Inn For Local Drifters "<< endl;
	cout << "\nYou Pat Down Your Clothes And Reconize What Your Wearing..... You Are A... " <<endl;
	cout << "\n" << "\n<W>arrior" << "\n<M>age" << "\n<P>riest" << endl; 
	cin >> Pick;
	if(Pick == 'W')
	{
		cout <<"\n Thats Right You Are A Warrior! Bravest Of The Brave!" <<endl;
		Job = 'W';
	}
	if(Pick == 'M')
	{
		cout <<"\n Thats Right You Are A Mage! May The Elements Bring Great Power To You!"<<endl;
		Job = 'M';
	}
	if(Pick == 'P')
	{
		cout <<"\n Thats Right You Are A Priest! Maybe Not The Holiest But Hey!"<<endl;
		Job = 'P';
	}

	system("pause");
	system("cls");

	cout <<" After Getting Cleaned Up You Head Downstairs Into The Bar " <<endl;
	system("pause");
	system("cls");
	Points();

	return;

}

void Points()
{
	if(Job == 'W')
	{
		Atk = 10;
		Def = 5;
		HpMax = 20;
		Hp = HpMax;
		Gold = 10;
		Exp = 0;
		ExpMax = 30;

	}
	if(Job == 'M')
	{
		Atk = 5;
		Def = 10;
		HpMax = 20;
		Hp = HpMax;
		Gold = 10;
		Exp = 0;
		ExpMax = 30;
	}
	if(Job == 'P')
	{
		Atk = 5;
		Def = 5;
		HpMax = 30;
		Hp = HpMax;
		Gold = 10;
		Exp = 0;
		ExpMax = 30;
	}

	return;
}

void Stat()
{
	system("cls");
	cout <<" *-----[ Your Stats ]-----* " << "\n" << endl;
	cout <<"\nAttack:" << Atk <<"\nDefence:" << Def <<"\nHitPoints:" << Hp << "/" << HpMax <<"\nGold:" << Gold <<"\nExperiance:" << Exp <<"/" << ExpMax <<"\n" << endl;
	system("pause");
	system("cls");
	Inn();

	return;
}

void Inn()
{
	system("cls");
	cout <<"\nYou Look Around The Bar And See A Bunch Of Drunks, A Bartender, And A Staircase." << endl;
	cout <<"\n"<<"\n<D>runks"<<"\n<B>artender"<<"\n<U>pstairs"<<"\n<V>iew Your Stats"<<"\n<L>eave Bar And Go Outside"<<"\n" << endl;
	cin >> Pick;
	if(Pick == 'D')
	{
		cout <<"\nA Drunk Screams At You.... GO AWAY!!!!"<< endl;
		Inn();
	}
	if(Pick == 'B')
	{
		cout <<"\n What Would You Like To Order?" << endl;
		cout <<"\n "<< "<F>ighting Fury - 10g " << "\n<R>hum On The ROCKS - 10g" << "\n<M>oonShine - 20g" <<"\n<L>eave Bar"<< endl;
		cin >> Pick;
		if(Pick == 'F')
		{
			if(Gold < 10)
			{
				cout << "\nSorry Not Enough Gold!"<<endl;
				system("pause");
			}
			else
			{
			Gold = Gold - 10;
			Atk++;
			cout <<"\n Gained 1 Attack!" <<endl;
			system("pause");
			}
		}
		if(Pick == 'R')
		{
			if(Gold < 10)
			{
				cout << "/nSorry Not Enough Gold!"<<endl;
				system("pause");
			}
			else
			{
			Gold = Gold - 10;
			Def++;
			cout <<"\n Gained 1 Defence!" <<endl;
			system("pause");
			}
		}
		if(Pick == 'M')
		{
			if(Gold < 20)
			{
				cout << "Sorry Not Enough Gold!"<<endl;
				system("pause");
			}
			else
			{
			Gold = Gold - 20;
			HpMax = HpMax + 5;
			cout <<"\n Gained 5 Max Hitpoints!" <<endl;
			system("pause");
			}

		}
		if(Pick == 'B')
		{
			Inn();
		}

		Inn();

	}

	if (Pick == 'U')
	{
		cout <<" You Run Back To Your Room And Take A Quick Nap... You Awaken Feeling Refreshed!" <<endl;
		Hp = HpMax;
		system("pause");
		Inn();
	}


	if(Pick == 'V')
	{
		Stat();
	}

	if(Pick == 'L')
	{
		cout << "\nYou Gather Your Things And Start Your Journey!";
		system("pause");
		Outside();

	}
	else
	{
		Inn();
	}


	return;
}

void Outside()
{
	system("cls");
	cout<<"\n You Journey Outside And Look Around. You Feel Cheery Since It Is Such A Beautiful Day..."<<endl;
	cout<<"\n Then You Remember The Horror Begining Caused By The Demon! It Must Be Stopped!"<<endl;
	cout<<"\n" << "\n<F>orest" <<"\n<I>nn" << "\n<T>emple" <<"\n<V>iew Your Stats" << endl;

	cin >> Pick;

if(Pick == 'F')
{
	Forest();
}
if(Pick == 'I')
{
	Inn();
}
if(Pick == 'T')
{
	Temple();
}
if(Pick == 'V')
{
	Stat();
}

return;
}

void Forest()
{
	cout << "\n You Look Around And Suddenly You Are Attacked By A" << endl;
	if (Boss == 1)
	{
		cout << "Lizard" <<endl;
	}
	if (Boss == 2)
	{
		cout << "Witch" <<endl;
	}
	if (Boss == 3)
	{
		cout << "Dragon" <<endl;
	}
	system("pause");

	if(Boss == 1)
	{
		Eatk = 5;
		EDef = 4;
		EMaxHp = 15;
		EHp = EMaxHp;
		EGold = 4;
		EExp = 5;
		Fight();
	}
	if(Boss == 2)
	{
		Eatk = 9;
		EDef = 8;
		EMaxHp = 30;
		EHp = EMaxHp;
		EGold = 8;
		EExp = 8;
		Fight();
	}
	if(Boss == 3)
	{
		Eatk = 13;
		EDef = 12;
		EMaxHp = 50;
		EHp = EMaxHp;
		EGold = 12;
		EExp = 12;
		Fight();
	}

	return;
}

void FightLaunch()
{
	if(EHp < 0)
	{
		cout <<"\n You Have Slain The Creature!" << "\n Gained" << EGold << "Gold!" << "\n Gained" << EExp << "Experiance!"<<endl;
		Gold = Gold + EGold;
		Exp = Exp + EExp;
		EHp = EMaxHp;
		system("pause");
		Outside();
	}
	if(Hp < 0)
	{
		cout <<"\n You Have Been Killed In Action!" << "\n Lost Half Your Gold" << "\n Lost Half Your Experiance" <<endl;
		Gold = Gold / 2;
		Exp = Exp / 2;
		Hp = HpMax;
		system("pause");
		Inn();
	}
	Fight();

	return;
}
void FightProcess()
{
system("pause");
	EHp = EHp + (EDef / 2 - Atk);
	cout << "\nCreature took " << (EDef / 2 - Atk)
	<< " Damage" << endl;
	Hp = Hp + (Def / 2 - Eatk);
	cout << "\nYou Have Taken " << (Def / 2 - Eatk)
	<< " Damage" << endl;

system("pause");
FightLaunch();

	return;
}



void Fight()
{


	system("cls");
	cout << "\n *------------[ FIGHT ]------------*" << "\n"
	<< " Enemy Hp :" << EHp << " / " << EMaxHp
	<< "\n" << " Your HP :" << Hp << "/" << HpMax
	<< "\n" << " <A>ttack"  << "\n <R>un Away"<< endl;
	cin >> Pick;
	if(Pick == 'R')
	{
		Outside();
	}
	if(Pick == 'A')
	{
		FightProcess();
	}
return;
}

void Temple()
{
	system("cls");
	if(Exp >= ExpMax)
	{
		cout <<"\n The Monks Feel Your Strength As You Walk The Stone HallWays"
			<< "\n If You Defeat The Awaiting Beast, You Will Be 1 Step Closer To The Demon" <<endl;
		system("pause");
		Boss1();
	}
	else
	{
		cout <<"\n The Monks Will Not Allow You Inside, You Are Not Yet Ready!" <<endl;
		system("pause");
		Outside();
	}

}

void Boss1()
{

	if(Boss == 1)
	{
		BMaxHp = 30;
		BHp = EMaxHp;
		Batk = 10;
		BDef = 8;
		BGold = 15;
		BExp = 5;
		BossFight();
	}
	if(Boss == 2)
	{
		BMaxHp = 60;
		BHp = EMaxHp;
		Batk = 14;
		BDef = 14;
		BGold = 20;
		BExp = 10;
		BossFight();
	}
	if(Boss == 3)
	{
		BMaxHp = 90;
		BHp = EMaxHp;
		Batk = 22;
		BDef = 22;
		BGold = 20;
		BExp = 15;
		BossFight();
	}

	return;
}

void BossFight()
{


	system("cls");
	cout << "\n *------------[ BOSS ]------------*" << "\n"
	<< " Enemy Hp :" << BHp << " / " << BMaxHp
	<< "\n" << " Your HP :" << Hp << "/" << HpMax
	<< "\n" << " <A>ttack"  << "\n <R>un Away"<< endl;
	cin >> Pick;
	if(Pick == 'R')
	{
		Outside();
	}
	if(Pick == 'A')
	{
		BossProcess();
	}
return;
}
void BossProcess()
{
system("pause");
	BHp = BHp + (BDef / 2 - Atk);
	cout << "\nCreature took " << (BDef / 2 - Atk)
	<< " Damage" << endl;
	Hp = Hp + (Def / 2 - Batk);
	cout << "\nYou Have Taken " << (Def / 2 - Batk)
	<< " Damage" << endl;

system("pause");
BossLaunch();

	return;
}

void BossLaunch()
{
	if(BHp < 0)
	{
		cout <<"\n You Have Defeated A Boss! " << "\n Stats Have Increased! " << "\n Gained" << EGold << "Gold!" << "\n Gained" << EExp << "Experiance!"<<endl;
		Gold = Gold + BGold;
		Exp = Exp + BExp;
		BHp = BMaxHp;
		HpMax = HpMax + 15;
		Boss++;
		ExpMax = ExpMax * 2;
		Atk = Atk + 5;
		Def = Def + 5;
		system("pause");
		if (Boss ==4)
		{
			cout <<"\n You Slowly Step Out From The Temple, Battered And Bruised..." << "\n To Your Surprise Hundreds Of People Stand Before You Cheering You On... "<< "\n You Have Defeated The Great Demon! Thank You For Playing! " << endl;
		}
		Outside();
	}
	if(Hp < 0)
	{
		cout <<"\n You Have Been Killed In Action!" << "\n Lost Half Your Gold" << "\n Lost Half Your Experiance" <<endl;
		Gold = Gold / 2;
		Exp = Exp / 2;
		Hp = HpMax;
		system("pause");
		Inn();
	}

	BossFight();

	return;
}
