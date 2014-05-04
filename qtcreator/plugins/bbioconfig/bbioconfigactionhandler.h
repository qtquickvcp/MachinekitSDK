#ifndef BBIOCONFIGACTIONHANDLER_H
#define BBIOCONFIGACTIONHANDLER_H

#include <coreplugin/id.h>

#include <QObject>

QT_BEGIN_NAMESPACE
class QKeySequence;
class QSignalMapper;
QT_END_NAMESPACE

namespace BBIOConfig {
namespace Internal {

class BBIOConfigActionHandler : public QObject
{
    Q_OBJECT

public:
    explicit BBIOConfigActionHandler(QObject *parent = 0);
    void createActions();

public slots:
    void actionTriggered(int supportedAction);

protected:

    void registerNewAction(int actionId, const Core::Id &id, const QString &title,
                           const QKeySequence &key);

private:
    QSignalMapper *m_signalMapper;

};

} // namespace Internal
} // namespace BBIOConfig

#endif // BBIOCONFIGACTIONHANDLER_H
