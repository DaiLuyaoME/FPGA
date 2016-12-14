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

void Dialog::genWriteData()
{
    unsigned int temp=0;
    if(ui->led_1->isChecked()) temp += 128;
    if(ui->led_2->isChecked()) temp += 64;
    if(ui->led_3->isChecked()) temp += 32;
    if(ui->led_4->isChecked()) temp += 16;
    if(ui->led_5->isChecked()) temp += 8;
    if(ui->led_6->isChecked()) temp += 4;
    if(ui->led_7->isChecked()) temp += 2;
    if(ui->led_7->isChecked()) temp += 1;
    dataToWrite=QByteArray::fromHex(QByteArray::number(temp,16));
    myPort->write(dataToWrite);

}

void Dialog::on_led_1_clicked()
{
    genWriteData();
}

void Dialog::on_led_2_clicked()
{
    genWriteData();
}

void Dialog::on_led_3_clicked()
{
    genWriteData();
}

void Dialog::on_led_4_clicked()
{
    genWriteData();
}

void Dialog::on_led_5_clicked()
{
    genWriteData();
}

void Dialog::on_led_6_clicked()
{
    genWriteData();
}

void Dialog::on_led_7_clicked()
{
    genWriteData();
}

void Dialog::on_led_8_clicked()
{
    genWriteData();
}
