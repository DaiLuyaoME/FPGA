#ifndef DIALOG_H
#define DIALOG_H

#include <QDialog>
#include <QtSerialPort/QtSerialPort>
#include <QtSerialPort/QSerialPortInfo>
#include <QString>
namespace Ui {
class Dialog;
}

class Dialog : public QDialog
{
    Q_OBJECT

public:
    explicit Dialog(QWidget *parent = 0);
    ~Dialog();

private:
    void initPort();
private slots:
    void changeDisplay();
    void genWriteData();


    void on_led_1_clicked();

    void on_led_2_clicked();

    void on_led_3_clicked();

    void on_led_4_clicked();

    void on_led_5_clicked();

    void on_led_6_clicked();

    void on_led_7_clicked();

    void on_led_8_clicked();

private:
    Ui::Dialog *ui;
    QSerialPort *myPort;
    QByteArray buffer;
    QByteArray dataToWrite;
};

#endif // DIALOG_H
