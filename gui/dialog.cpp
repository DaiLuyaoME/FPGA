#include "dialog.h"
#include "ui_dialog.h"
#include <QtDebug>
Dialog::Dialog(QWidget *parent) :
    QDialog(parent),
    ui(new Ui::Dialog)
{
    ui->setupUi(this);
    ui->lcdNumber->display(10.4);
    initPort();
    connect(myPort,&QSerialPort::readyRead,this,&Dialog::changeDisplay);

}

Dialog::~Dialog()
{
    delete ui;
}

void Dialog::initPort()
{
    myPort = new QSerialPort(this);
    myPort->setPortName(QString("COM3"));
    myPort->setBaudRate(QSerialPort::Baud9600);
    myPort->setDataBits(QSerialPort::Data8);
    myPort->setFlowControl(QSerialPort::NoFlowControl);
    myPort->setParity(QSerialPort::NoParity);
    myPort->setStopBits(QSerialPort::OneStop);
    myPort->open(QIODevice::ReadWrite);


}

void Dialog::changeDisplay()
{
    buffer = myPort->read(1);
    qDebug()<<buffer;
    bool ok;
    int temp=buffer.toHex().toInt(&ok,16);
    qDebug()<<temp;
    double data=2.5*(temp/255.0);
    qDebug()<<data;
    ui->lcdNumber->display(data);

}
