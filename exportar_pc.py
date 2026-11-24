import sqlite3,json,sys
from pathlib import Path
p=Path(sys.argv[1] if len(sys.argv)>1 else 'financas.db')
if not p.is_file(): raise SystemExit('Banco não encontrado. Informe o caminho de financas.db.')
with sqlite3.connect(p.resolve().as_uri()+'?mode=ro',uri=True) as c:
 c.row_factory=sqlite3.Row
 data={t:[dict(r) for r in c.execute('SELECT * FROM '+t)] for t in ('accounts','entries')}
Path('financas-backup-pc.json').write_text(json.dumps(data,ensure_ascii=False),encoding='utf-8')
print('Backup criado: financas-backup-pc.json')
