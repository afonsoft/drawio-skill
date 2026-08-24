# Angular Test Template (Karma + Jasmine)

Template para testes unitários em Angular usando Karma e TestBed.

## Estrutura Básica

```typescript
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { {{ComponentName}} } from './{{component-file}}';

describe('{{ComponentName}}', () => {
  let component: {{ComponentName}};
  let fixture: ComponentFixture<{{ComponentName}};
  let httpMock: HttpTestingController;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ {{ComponentName}} ],
      imports: [HttpClientTestingModule],
      providers: [
        // Adicione providers necessários aqui
      ]
    }).compileComponents();

    fixture = TestBed.createComponent({{ComponentName}});
    component = fixture.componentInstance;
    httpMock = TestBed.inject(HttpTestingController);
    fixture.detectChanges();
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  // Adicione testes específicos aqui
});
```

## Testes de Componentes com Inputs

```typescript
describe('{{ComponentName}}', () => {
  let component: {{ComponentName}};
  let fixture: ComponentFixture<{{ComponentName}};

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ {{ComponentName}} ]
    }).compileComponents();

    fixture = TestBed.createComponent({{ComponentName}});
    component = fixture.componentInstance;
  });

  it('should display input value', () => {
    component.{{inputName}} = '{{testValue}}';
    fixture.detectChanges();
    const element = fixture.nativeElement.querySelector('.{{css-class}}');
    expect(element.textContent).toContain('{{testValue}}');
  });
});
```

## Testes de Serviços

```typescript
import { TestBed } from '@angular/core/testing';
import { HttpClientTestingModule, HttpTestingController } from '@angular/common/http/testing';
import { {{ServiceName}} } from './{{service-file}}';

describe('{{ServiceName}}', () => {
  let service: {{ServiceName}};
  let httpMock: HttpTestingController;

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [HttpClientTestingModule],
      providers: [ {{ServiceName}} ]
    });
    service = TestBed.inject({{ServiceName}});
    httpMock = TestBed.inject(HttpTestingController);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });

  it('should fetch data from API', () => {
    const mockData = { id: 1, name: 'Test' };
    service.getData().subscribe(data => {
      expect(data).toEqual(mockData);
    });

    const req = httpMock.expectOne('/api/data');
    expect(req.request.method).toBe('GET');
    req.flush(mockData);
  });
});
```

## Testes de Pipes

```typescript
import { {{PipeName}} } from './{{pipe-file}}';

describe('{{PipeName}}', () => {
  it('should transform value', () => {
    const pipe = new {{PipeName}}();
    expect(pipe.transform('{{input}}')).toBe('{{expectedOutput}}');
  });
});
```

## Testes de Diretivas

```typescript
import { ComponentFixture, TestBed } from '@angular/core/testing';
import { {{DirectiveName}} } from './{{directive-file}}';

describe('{{DirectiveName}}', () => {
  let component: TestComponent;
  let fixture: ComponentFixture<TestComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ {{DirectiveName}}, TestComponent ]
    }).compileComponents();

    fixture = TestBed.createComponent(TestComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should apply directive behavior', () => {
    const element = fixture.nativeElement.querySelector('.{{css-class}}');
    expect(element).toHaveClass('{{expected-class}}');
  });
});

@Component({
  template: '<div {{directiveName}} class="{{css-class}}">Test</div>'
})
class TestComponent {}
```

## Boas Práticas

- Use `TestBed` para configurar o ambiente de teste
- Use `HttpClientTestingModule` para testes de HTTP
- Use `async/await` para configuração assíncrona
- Chame `fixture.detectChanges()` após alterar propriedades
- Use `httpMock.verify()` para garantir que todas as requisições foram tratadas
- Teste comportamento, não implementação
- Use descrições claras e em português (Given/When/Then)
