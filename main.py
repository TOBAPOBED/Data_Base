import psycopg2
from psycopg2 import sql


def create_db(conn):
    """Создаёт структуру БД: таблицы clients и phones."""
    with conn.cursor() as cur:
        cur.execute("""
            CREATE TABLE IF NOT EXISTS clients (
                id SERIAL PRIMARY KEY,
                first_name VARCHAR(100) NOT NULL,
                last_name VARCHAR(100) NOT NULL,
                email VARCHAR(100) UNIQUE NOT NULL
            );
        """)
        cur.execute("""
            CREATE TABLE IF NOT EXISTS phones (
                id SERIAL PRIMARY KEY,
                client_id INTEGER NOT NULL REFERENCES clients(id) ON DELETE CASCADE,
                phone VARCHAR(20) NOT NULL
            );
        """)
    conn.commit()
    print("✓ Таблицы созданы.")


def add_client(conn, first_name, last_name, email, phones=None):
    """Добавляет нового клиента. phones — список телефонов (опционально)."""
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO clients (first_name, last_name, email) VALUES (%s, %s, %s) RETURNING id;",
            (first_name, last_name, email)
        )
        client_id = cur.fetchone()[0]

        if phones:
            for phone in phones:
                cur.execute(
                    "INSERT INTO phones (client_id, phone) VALUES (%s, %s);",
                    (client_id, phone)
                )
    conn.commit()
    print(f"✓ Клиент добавлен. ID: {client_id}")
    return client_id


def add_phone(conn, client_id, phone):
    """Добавляет телефон существующему клиенту."""
    with conn.cursor() as cur:
        cur.execute(
            "INSERT INTO phones (client_id, phone) VALUES (%s, %s);",
            (client_id, phone)
        )
    conn.commit()
    print(f"✓ Телефон {phone} добавлен клиенту ID {client_id}.")


def change_client(conn, client_id, first_name=None, last_name=None, email=None, phones=None):
    """Изменяет данные клиента. phones — новый список телефонов (заменяет старые)."""
    with conn.cursor() as cur:
        if first_name:
            cur.execute(
                "UPDATE clients SET first_name = %s WHERE id = %s;",
                (first_name, client_id)
            )
        if last_name:
            cur.execute(
                "UPDATE clients SET last_name = %s WHERE id = %s;",
                (last_name, client_id)
            )
        if email:
            cur.execute(
                "UPDATE clients SET email = %s WHERE id = %s;",
                (email, client_id)
            )
        if phones is not None:
            cur.execute("DELETE FROM phones WHERE client_id = %s;", (client_id,))
            for phone in phones:
                cur.execute(
                    "INSERT INTO phones (client_id, phone) VALUES (%s, %s);",
                    (client_id, phone)
                )
    conn.commit()
    print(f"✓ Данные клиента ID {client_id} обновлены.")


def delete_phone(conn, client_id, phone):
    """Удаляет конкретный телефон у клиента."""
    with conn.cursor() as cur:
        cur.execute(
            "DELETE FROM phones WHERE client_id = %s AND phone = %s;",
            (client_id, phone)
        )
        if cur.rowcount == 0:
            print(f"✗ Телефон {phone} у клиента ID {client_id} не найден.")
        else:
            print(f"✓ Телефон {phone} удалён у клиента ID {client_id}.")
    conn.commit()


def delete_client(conn, client_id):
    """Удаляет клиента и все его телефоны (благодаря ON DELETE CASCADE)."""
    with conn.cursor() as cur:
        cur.execute("DELETE FROM clients WHERE id = %s;", (client_id,))
        if cur.rowcount == 0:
            print(f"✗ Клиент ID {client_id} не найден.")
        else:
            print(f"✓ Клиент ID {client_id} удалён.")
    conn.commit()


def find_client(conn, first_name=None, last_name=None, email=None, phone=None):
    """Ищет клиента по имени, фамилии, email или телефону."""
    query = """
        SELECT DISTINCT c.id, c.first_name, c.last_name, c.email, p.phone
        FROM clients c
        LEFT JOIN phones p ON c.id = p.client_id
        WHERE 1=1
    """
    params = []

    if first_name:
        query += " AND c.first_name = %s"
        params.append(first_name)
    if last_name:
        query += " AND c.last_name = %s"
        params.append(last_name)
    if email:
        query += " AND c.email = %s"
        params.append(email)
    if phone:
        query += " AND p.phone = %s"
        params.append(phone)

    with conn.cursor() as cur:
        cur.execute(query, params)
        rows = cur.fetchall()

    if not rows:
        print("✗ Клиент не найден.")
        return

    print(f"{'ID':<4} {'Имя':<15} {'Фамилия':<15} {'Email':<25} {'Телефон'}")
    print("-" * 75)
    for row in rows:
        client_id, first, last, em, ph = row
        print(f"{client_id:<4} {first:<15} {last:<15} {em:<25} {ph or '—'}")
    return rows


# ============================================================
# ДЕМОНСТРАЦИЯ РАБОТЫ
# ============================================================
if __name__ == "__main__":
    with psycopg2.connect(
        database="clients",
        user="postgres",
        password="",
        host="localhost"
    ) as conn:
        # 1. Создаём БД
        create_db(conn)

        # 2. Добавляем клиентов
        id1 = add_client(conn, "Иван", "Петров", "ivan@mail.ru", phones=["+79001112233", "+79004445566"])
        id2 = add_client(conn, "Мария", "Сидорова", "maria@mail.ru", phones=["+79007778899"])
        id3 = add_client(conn, "Алексей", "Смирнов", "alex@mail.ru")  # без телефона

        # 3. Добавляем телефон существующему клиенту
        add_phone(conn, id3, "+79001234567")

        # 4. Изменяем данные клиента
        change_client(conn, id1, email="ivan.new@mail.ru", phones=["+79009998877"])

        # 5. Удаляем телефон
        delete_phone(conn, id2, "+79007778899")

        # 6. Ищем клиентов
        print("\n--- Поиск по email ---")
        find_client(conn, email="ivan.new@mail.ru")

        print("\n--- Поиск по телефону ---")
        find_client(conn, phone="+79001234567")

        print("\n--- Поиск по фамилии ---")
        find_client(conn, last_name="Смирнов")

        # 7. Удаляем клиента
        delete_client(conn, id3)

        print("\n--- Все клиенты после удаления ---")
        find_client(conn)