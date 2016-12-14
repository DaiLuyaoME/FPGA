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


private:
    Ui::Dialog *ui;
    QSerialPort *myPort;
    QByteArray buffer;
};

#endif // DIALOG_H
